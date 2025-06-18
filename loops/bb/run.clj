(require '[languages.benchmark :as benchmark])

(defn main [u]
  (let [r (rand-int 10000) ; Get a random number 0 <= r < 10k
        v' (vec (repeat 10000 0)) ; Vector of 10k elements initialized to 0
        v (mapv (fn [initial-value]
                  (let [inner-sum (reduce (fn [sum j]
                                            (+ sum (rem j u))) ; Simple sum
                                          initial-value
                                          (range 10000))] ; 10k inner loop iterations, per outer loop iteration
                    (+ inner-sum r))) ; Add a random value to each element in array
                v')] ; 10k outer loop iterations
    (nth v r))) ; Print out a single element from the array


(let [run-ms (parse-long (first *command-line-args*))
      ; skip warmup arg, because we skip warmups
      u (parse-long (nth *command-line-args* 2))]
  (-> (benchmark/run #(main u) run-ms)
      benchmark/format-results
      println))
