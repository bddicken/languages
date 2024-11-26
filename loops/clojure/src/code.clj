(ns code
  (:gen-class))

(defn -main [& args]
  (let [u (parse-long (first args))
        r (rand-int 10000)]
    (-> (map
         (fn [_]
           (reduce (fn [acc j]
                     (+ acc (mod j u)))
                   r
                   (range 10000)))
         (range 10000))
        (nth r)
        (println))))
