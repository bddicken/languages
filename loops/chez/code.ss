#!chezscheme
(import (chezscheme))

(define (main args)
  (define u (string->number (cadr args)))
  (define prng (make-pseudo-random-generator))
  (define r (pseudo-random-generator-next! prng 10000))
  (define a (make-fxvector 10000 0))
  (do [(i 0 (fx1+ i))]
	  [(fx>= i 10000)]
	(do [(j 0 (fx1+ j))]
		[(fx>= j 100000)]
	  (fxvector-set!
	   a i
	   (fx+ (fxmod j u) (fxvector-ref a i))))
	(fxvector-set!
	 a i
	 (fx+ r (fxvector-ref a i))))
  (display (fxvector-ref a r))
  (newline))

(main (command-line))
