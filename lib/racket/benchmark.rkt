#lang racket

(provide run format-results
         (struct-out results))

;; Results across processes are not comparable!
(define (current-monotonic-nanotime)
  (inexact->exact (round (* (current-inexact-monotonic-milliseconds) 1000000))))

;; runs: number of runs
(struct results [runs result mean-ms min-ms max-ms std-dev-ms])

;; run : (-> any) number -> results
;;
;; f is the function to run repeatedly.
;; run-ms is the total run time in milliseconds.
;;
;; Special cases:
;;   * run-ms = 0 => don’t run, just return a “dummy” result.
;;   * run-ms = 1 => don’t print status dots (assumed to be a correctness check).
(define (run f run-ms)
  (cond
    [(zero? run-ms)
     (results 0 (f) 0 0 0 0)]
    [else
     ; convert run-ms (milliseconds) to nanoseconds
     (define run-ns (* run-ms 1000000))
     (define init-t (current-monotonic-nanotime))
     (define last-status-t init-t)
     (when (> run-ms 1)
       (display "." (current-error-port))
       (flush-output (current-error-port)))
     (define-values (total-elapsed-time result runs elapsed-times)
       (let loop ([last-tet 0]
                  [elapsed-times '()]
                  ;; better to track this than walk the elapsed-times list for length
                  [runs 0]
                  [last-status-t last-status-t])
         (define t0 (current-monotonic-nanotime))
         (define result (f))
         (define t1 (current-monotonic-nanotime))
         (define elapsed-time (- t1 t0))
         (define total-elapsed-time (+ last-tet elapsed-time))
         (define print-status? (and (> run-ms 1)
                                    (> (- t0 last-status-t) 1000000000)))
         (when print-status?
           (display "." (current-error-port))
           (flush-output (current-error-port)))
         (if (< total-elapsed-time run-ns)
             (loop total-elapsed-time
                   (cons elapsed-time elapsed-times)
                   (add1 runs)
                   (if print-status? t1 last-status-t))
             (values total-elapsed-time
                     result
                     (add1 runs)
                     (reverse (cons elapsed-time elapsed-times))))))
     (define mean-ns (/ total-elapsed-time runs))
     (define min-ns (argmin values elapsed-times))
     (define max-ns (argmax values elapsed-times))
     (define variance (for/fold ([total 0]
                                 #:result (/ total runs))
                                ([t (in-list elapsed-times)])
                        (+ total (sqr (- t mean-ns)))))
     (define std-dev-ns (sqrt variance))
     (define mean-ms (/ mean-ns 1000000.0))
     (define min-ms (/ min-ns 1000000.0))
     (define max-ms (/ max-ns 1000000.0))
     (define std-dev-ms (/ std-dev-ns 1000000.0))
     (when (> run-ms 1)
       (newline (current-error-port)))
     (results runs result mean-ms min-ms max-ms std-dev-ms)]))

;; format-results : results -> string
;; Formats the benchmark results as:
;;   mean-ms,std-dev-ms,min-ms,max-ms,runs,result
(define (format-results stats)
  (match stats
    [(results runs result mean-ms min-ms max-ms std-dev-ms)
     (format "~a,~a,~a,~a,~a,~a"
             mean-ms
             std-dev-ms
             min-ms
             max-ms
             runs
             result)]))
