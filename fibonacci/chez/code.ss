#!chezscheme
(import (chezscheme))

(define (fib n)
  (cond
   [(fxzero? n) 0]
   [(fx= 1 n) 1]
   [else (fx+ (fib (fx- n 1))
			  (fib (fx- n 2)))]))

(define (main args)
  (define u (string->number (cadr args)))
  (display
   (do [(i 1 (fx1+ i))
		(r 0 (fx+ r (fib i)))]
	   [(>= i u)
		r]))
  (newline))

(main (command-line))
