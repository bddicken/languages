#-sbcl (error "only Steel Bank Common Lisp supported, sorry")

(defun main ()
  (declare (optimize (speed 3) (safety 0)))
  (let ((r (random 10000 (make-random-state t)))
        (a (make-array 10000   :element-type '(unsigned-byte 32) ))
        (u (parse-integer (second *posix-argv*)) ))
    (declare
     (type (mod 10000) r)
     (type (unsigned-byte 32) u)
     (type (simple-array (unsigned-byte 32) (10000)) a))


    (loop for i of-type (mod 10001) from 0 below 10000 do
      (loop for j of-type (mod 100001) from 0 below 100000 do
        (setf (aref a i) (mod j u)))
      (setf (aref a i) (+ (aref a i) r)))
    (format t "~a" (aref a r))))

;; compile or run depending on args and situation.
(if (member "--build" sb-ext:*posix-argv* :test #'string=)
    (sb-ext:save-lisp-and-die "./common-lisp/code"
                            :toplevel #'main
                            :executable t
                            :save-runtime-options t)
    (main))
