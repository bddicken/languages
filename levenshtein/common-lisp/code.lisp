;; Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
;; Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
;; Time Complexity: O(m*n) where m and n are the lengths of the input strings
(declaim (optimize (speed 3) (safety 0) (debug 0)))

(defun levenshtein-distance (s1 s2)
  (declare (type string s1 s2)
           (values fixnum))
  ;; Early termination checks
  (cond ((string= s1 s2) 0)
        ((zerop (length s1)) (length s2))
        ((zerop (length s2)) (length s1))
        (t
         ;; Make s1 the shorter string for space optimization
         (when (> (length s1) (length s2))
           (rotatef s1 s2))
         
         (let* ((m (length s1))
                (n (length s2))
                ;; Use simple-vectors for better performance
                (prev-row (make-array (1+ m) :element-type 'fixnum))
                (curr-row (make-array (1+ m) :element-type 'fixnum)))
           
           (declare (type fixnum m n)
                    (type (simple-array fixnum (*)) prev-row curr-row))
           
           ;; Initialize first row
           (loop for i from 0 to m do
                 (setf (aref prev-row i) i))
           
           ;; Main computation loop
           (loop for j from 1 to n do
                 (setf (aref curr-row 0) j)
                 
                 (loop for i from 1 to m do
                       (let ((cost (if (char= (char s1 (1- i))
                                            (char s2 (1- j)))
                                     0 1)))
                         (declare (type fixnum cost))
                         
                         ;; Calculate minimum of three operations
                         (setf (aref curr-row i)
                               (min (1+ (aref prev-row i))      ; deletion
                                    (1+ (aref curr-row (1- i))) ; insertion
                                    (+ (aref prev-row (1- i))   ; substitution
                                       cost)))))
                 
                 ;; Swap rows using replace
                 (replace prev-row curr-row))
           
           (aref prev-row m)))))

(defun main ()
  (let* ((args (rest sb-ext:*posix-argv*))
         (min-distance -1)
         (times 0))
    
    (when (< (length args) 2)
      (format t "Please provide at least two strings as arguments.~%")
      (sb-ext:exit :code 1))
    
    ;; Compare all pairs of strings
    (loop for i from 0 below (length args)
          do (loop for j from 0 below (length args)
                   when (/= i j)
                   do (let ((distance (levenshtein-distance (nth i args)
                                                          (nth j args))))
                        (when (or (= min-distance -1)
                                (< distance min-distance))
                          (setf min-distance distance))
                        (incf times))))
    
    (format t "times: ~D~%" times)
    (format t "min_distance: ~D~%" min-distance)))

;; Run main when script is executed
(main)
