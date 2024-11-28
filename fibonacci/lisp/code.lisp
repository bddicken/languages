(defpackage :language-test
  (:use :cl)
  (:export #:main
		   #:fibonacci))

(in-package :language-test)

(defun parse-arguments ()
  "Parse the command-line arguments to extract `num`."
  (let ((args (cdr sb-ext:*posix-argv*))) ; Skip the program name
    (if (and args (every #'digit-char-p (first args)))
        (parse-integer (first args))     ; Convert the first argument to an integer
        (error "Please provide a valid integer as the argument!"))))

;; (defun fibonacci (n &optional (a 0) (b 1))
;;   (if (zerop n)
;;       nil
;;       (cons a (fibonacci (1- n) b (+ a b)))))

(defun fibonacci (n)
  "Recursive Fibonacci function like the C implementation."
  (cond
    ((= n 0) 0)
    ((= n 1) 1)
    (t (+ (fibonacci (- n 1)) (fibonacci (- n 2))))))

(defun sum-fibonacci (u)
  "Compute the sum of Fibonacci numbers from 1 to (u-1)."
  (loop for i from 1 below u
        summing (fibonacci i)))

(defun main ()
  "Main function to execute loop-test using a command-line argument."
  (let* ((num (parse-arguments))
		 ;; (fib (fibonacci num))
		 ;; (sum (reduce #'+ fib))
		 )
    ;; (format t "~d~%" sum)
	(format t "~d~%" (sum-fibonacci num))
	))

;; Ensure the program starts by calling MAIN
#-sbcl
(error "This script is designed to be run with SBCL.")

#+sbcl
(main)
