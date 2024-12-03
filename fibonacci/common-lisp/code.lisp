#-sbcl (error "only Steel Bank Common Lisp supported, sorry")

(declaim (ftype (function ((unsigned-byte 32)) unsigned-byte) fibonacci))
(defun fibonacci (n)
  (declare (type (unsigned-byte 32) n)
           (optimize (speed 3) (safety 0) (debug 0)))
  (case n
    (0 0)
    (1 1)
    (t (+ (fibonacci (1- n))
          (fibonacci (- n 2))))))

(defun main ()
  (declare (optimize (speed 3) (safety 0)))
  (let ((u (parse-integer (second *posix-argv*)) ))
    (declare
     (type (unsigned-byte 32) u))
    (let ((r (loop for i of-type (unsigned-byte 32) from 0 below u
                   sum
                   (fibonacci i) of-type unsigned-byte)))
      (declare (type unsigned-byte r))
      (format t "~a" r))))

;; compile or run depending on args and situation.
(if (member "--build" sb-ext:*posix-argv* :test #'string=)
    (sb-ext:save-lisp-and-die "./common-lisp/code"
                            :toplevel #'main
                            :executable t
                            :save-runtime-options t)
    (main))
