;;; -*- lexical-binding: t; -*-

(defun loops-main ()
  (declare (speed 3))
  (let* ((u (string-to-number (car command-line-args-left)))
         (r (random 10000))
         (a (make-vector 10000 0))
         (i 0))
    (while (< i 10000)
      (let ((j 0))
        (while (< j 100000)
          (aset a i (+ (aref a i) (mod j u)))
          (setq j (1+ j))))
      (aset a i (+ (aref a i) r))
      (setq i (1+ i)))
    (princ (aref a r))))

(loops-main)
