(defn- fibonacci [n]
  (if (<= n 1)
    n
    (+ (fibonacci (- n 1))
       (fibonacci (- n 2)))))

(defn main [u]
  (let [r (reduce (fn [sum i] 
                    (+ sum (fibonacci i)))
                  0 
                  (range 1 u))]
    (println r)))

(main (-> *command-line-args* first parse-long))