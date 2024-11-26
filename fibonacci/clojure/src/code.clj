(ns code
  (:gen-class))

(def fib
  (cons 1 (lazy-seq (cons 1 (map + (rest fib) fib)))))

(defn -main [& args]
  (let [u (parse-long (first args))]
    (->> fib
         (take (dec u))
         (reduce +')
         (println))))
