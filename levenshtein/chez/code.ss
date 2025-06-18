;; Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
;; Space Complexity: O(min(m,n)) - only uses two vectors instead of full matrix
;; Time Complexity: O(m*n) where m and n are the lengths of the input strings
(define (levenshtein-distance s1 s2)
  ;; Early termination checks
  (cond
    [(eq? s1 s2) 0]
    [(zero? (string-length s1)) (string-length s2)]
    [(zero? (string-length s2)) (string-length s1)]
    [else
      (let* ([s1 (if (> (string-length s1) (string-length s2))
                     s2
                     s1)]
             [s2 (if (> (string-length s1) (string-length s2))
                     s1
                     s2)]
             [m (string-length s1)]
             [n (string-length s2)]
             ;; Use vectors instead of lists for O(1) access
             [prev-row (make-vector (+ m 1) 0)]
             [curr-row (make-vector (+ m 1) 0)])
        
        ;; Initialize first row
        (do ([i 0 (+ i 1)])
            [(> i m)]
            (vector-set! prev-row i i))
        
        ;; Main computation loop
        (do ([j 1 (+ j 1)])
            [(> j n) (vector-ref prev-row m)]
          (vector-set! curr-row 0 j)
          
          (do ([i 1 (+ i 1)])
              [(> i m)]
            (let* ([cost (if (char=? (string-ref s1 (- i 1))
                                    (string-ref s2 (- j 1)))
                            0
                            1)]
                   [deletion (+ (vector-ref prev-row i) 1)]
                   [insertion (+ (vector-ref curr-row (- i 1)) 1)]
                   [substitution (+ (vector-ref prev-row (- i 1)) cost)])
              (vector-set! curr-row i
                          (min deletion insertion substitution))))
          
          ;; Swap rows using vector-copy!
          (vector-copy! prev-row 0 curr-row)))]))

;; Main program
(let* ([args (cdr (command-line))]
       [args-len (length args)])
  (if (< args-len 2)
      (begin
        (display "Please provide at least two strings as arguments.\n")
        (exit 1))
      (let loop ([i 0]
                 [j 0]
                 [min-distance -1]
                 [times 0])
        (if (>= i args-len)
            (begin
              (printf "times: ~a\n" times)
              (printf "min_distance: ~a\n" min-distance))
            (if (>= j args-len)
                (loop (+ i 1) 0 min-distance times)
                (if (= i j)
                    (loop i (+ j 1) min-distance times)
                    (let ([distance (levenshtein-distance
                                    (list-ref args i)
                                    (list-ref args j))])
                      (loop i
                            (+ j 1)
                            (if (or (= min-distance -1)
                                  (< distance min-distance))
                                distance
                                min-distance)
                            (+ times 1)))))))))
