#lang racket/base

(require racket/require
         (for-syntax racket/base) ;; filtered-in fails without this
         (only-in racket/fixnum
                  make-fxvector)
         (filtered-in
          (λ (name)
            (and (regexp-match #rx"^unsafe-fx" name)
                 (regexp-replace #rx"unsafe-" name "")))
          racket/unsafe/ops))

(define length #e1e4)
(define inner-loop (* 10 length))

(define u (string->number (vector-ref (current-command-line-arguments) 0)))
(define r (random (add1 length) (make-pseudo-random-generator)))
;; Racket's numeric tower makes doing exactly-32-bit integer computations
;; tricky. Since the results of the computation don't matter too much, let's use
;; fixnums, which are larger on 64-bit platforms but 1 or 2 bits shy on 32-bit
;; platforms. Given the same r and u, this should produce the same result as the
;; C program on a 64-bit platform (where it will unfortunately waste space).
;;
;; TODO: use make-s32vector, but what kinds of arithmetic operators for C
;; semantics?
(define a (make-fxvector length))

;; no /wraparound variants: if the reference C program exhibits any signed
;; integer overflow, it's in UB territory. Assume it doesn't.
;; https://stackoverflow.com/a/19843181
(for ([i (in-range 0 length)])
  (for ([j (in-range 0 inner-loop)])
    (fxvector-set! a i (fx+ (fxvector-ref a i) (fxremainder j u))))
  (fxvector-set! a i (fx+ (fxvector-ref a i) r)))

(displayln (fxvector-ref a r))
