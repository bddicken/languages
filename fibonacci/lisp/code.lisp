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

(defun fibonacci (n &optional (a 0) (b 1))
  (if (zerop n)
      nil
      (cons a (fibonacci (1- n) b (+ a b)))))

(defun main ()
  "Main function to execute loop-test using a command-line argument."
  (let* ((num (parse-arguments))
		 (fib (fibonacci num))
		 (sum (reduce #'+ fib)))
    (format t "~d~%" sum)))
