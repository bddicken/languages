#lang racket/base

(require racket/require
         (for-syntax racket/base) ;; filtered-in fails without this
         (filtered-in
          (λ (name)
            (and (regexp-match #rx"^unsafe-fx" name)
                 (regexp-replace #rx"unsafe-" name "")))
          racket/unsafe/ops))

(provide fibonacci)

(define (fibonacci a)
  (case a
    [(0 1) a]
    [else
     (fx+ (fibonacci (fx- a 1))
          (fibonacci (fx- a 2)))]))
