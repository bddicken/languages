;;; -*- lexical-binding: t; -*-

(defun languages-fibonacci (n)
  (declare (speed 3)
           (pure t)
           (side-effect-free t))
  (if (<= n 1)
      n
    (+ (languages-fibonacci (1- n))
       (languages-fibonacci (1- (1- n))))))

(defun languages-main ()
  (declare (speed 3))
  (let* ((u (string-to-number (car command-line-args-left)))
         (sum 0)
         (i 1))
    (while (< i u)
      (setq sum (+ sum (languages-fibonacci i)))
      (setq i (1+ i)))
    (princ sum)))

(languages-main)
