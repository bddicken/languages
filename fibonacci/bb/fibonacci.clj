(ns fibonacci)

(defn fibonacci [n]
  (case n
    0 0
    1 1
    (+ (fibonacci (- n 1))
       (fibonacci (- n 2)))))

