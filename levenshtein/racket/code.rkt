#lang racket/base

(require racket/require
         (for-syntax racket/base) ;; filtered-in fails without this
         (only-in racket/fixnum
                  make-fxvector
                  for/fxvector)
         (filtered-in
          (λ (name)
            (and (regexp-match #rx"^unsafe-fx" name)
                 (regexp-replace #rx"unsafe-" name "")))
          racket/unsafe/ops)
         racket/cmdline
         racket/list
         racket/match)

(define (levenshtein-distance x y)
  (define-values (a m b n)
    (let* ([m (string-length x)]
           [n (string-length y)]
           [m* (min m n)])
      (values (if (fx= m m*) x y)
              m*
              (if (fx= m m*) y x)
              (max m n))))
  (define prev (for/fxvector #:length (add1 m) ([i (in-inclusive-range 0 m)])
                 i))
  (define curr (make-fxvector (add1 m)))
  (for ([i (in-inclusive-range 1 n)])
    (fxvector-set! curr 0 i)
    (for ([j (in-inclusive-range 1 m)])
      (define cost (if (char=? (string-ref a (sub1 j)) (string-ref b (sub1 i))) 0 1))
      (define del (add1 (fxvector-ref prev j)))
      (define ins (add1 (fxvector-ref curr (sub1 j))))
      (define sub (+ (fxvector-ref prev (sub1 j)) cost))
      (fxvector-set! curr j (min del ins sub)))
    (for ([j (in-inclusive-range 0 m)])
      (fxvector-set! prev j (fxvector-ref curr j))))
  (fxvector-ref prev m))

(command-line
 #:args args
 (define-values (times min-distance)
   ;; Slight optimization: no need to loop over the entire set of args twice
   ;; since distance is symmetric. We do the same number of distance
   ;; calculations as the C program, but with a different strategy.
   (for/fold ([times 0] [min-distance #f])
             ([xy (in-combinations args 2)])
     (match-define (list x y) xy)
     (define dist (levenshtein-distance x y))
     (define mirror-dist (levenshtein-distance y x))
     (values (fx+ 2 times)
             (if min-distance
                 (fxmin min-distance dist mirror-dist)
                 (fxmin dist mirror-dist)))))
 (displayln (format "times: ~a" times))
 (displayln (format "min_distance: ~a" min-distance)))
