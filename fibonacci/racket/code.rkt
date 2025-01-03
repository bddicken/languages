#lang racket/base

(require racket/require
         (for-syntax racket/base) ;; filtered-in fails without this
         (filtered-in
          (λ (name)
            (and (regexp-match #rx"^unsafe-fx" name)
                 (regexp-replace #rx"unsafe-" name "")))
          racket/unsafe/ops))

(define (fibonacci a)
  (case a
    [(0 1) a]
    [else
     (fx+ (fibonacci (fx- a 1))
          (fibonacci (fx- a 2)))]))

(define u (string->number (vector-ref (current-command-line-arguments) 0)))

(for/fold ([r 0])
          ([i (in-range 1 u)])
  (fx+ r (fibonacci i)))
