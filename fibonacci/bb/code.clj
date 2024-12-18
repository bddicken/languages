(defn- fibonacci [n]
  (case n
    0 0
    1 1
    (+ (fibonacci (- n 1))
       (fibonacci (- n 2)))))

(defn main [u]
  (println (reduce + (map fibonacci (range u)))))

(main (-> *command-line-args* first parse-long))