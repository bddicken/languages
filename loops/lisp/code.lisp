(defpackage :language-test
  (:use :cl)
  (:export #:main
		   #:loop-test))

(in-package :language-test)

(defun parse-arguments ()
  "Parse the command-line arguments to extract `num`."
  (let ((args (cdr sb-ext:*posix-argv*))) ; Skip the program name
    (if (and args (every #'digit-char-p (first args)))
        (parse-integer (first args))     ; Convert the first argument to an integer
        (error "Please provide a valid integer as the argument!"))))

(defun loop-test (num)
  "Perform the loop test with NUM iterations."
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (let* ((r (random 10000))
         (a (make-array 10000 :element-type 'fixnum)))
    (declare (type fixnum num r)
             (type (simple-array fixnum (*)) a))
    (dotimes (i 10000)
      (let ((ai 0))
        (declare (type fixnum ai))
        (dotimes (j 100000)
          (declare (type fixnum j))
          (setf ai (+ ai (mod j num))))
        (setf (aref a i) (+ ai r))))
    (format t "~d~%" (aref a r))))

(defun main ()
  "Main function to execute loop-test using a command-line argument."
  (let ((num (parse-arguments)))
    (loop-test num)))
