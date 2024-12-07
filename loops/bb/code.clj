(defn main [u]
  (let [r (rand-int 10000) ; Get a random number 0 <= r < 10k
        v' (vec (repeat 10000 0)) ; Vector of 10k elements initialized to 0
        v (reduce (fn [v i]
                    (let [inner-sum (reduce
                                     (fn [sum j]
                                       (+ sum (rem j u))) ; Simple sum
                                     (v i)
                                     (range 100000))] ; 100k inner loop iterations, per outer loop iteration
                      (assoc v i (+ inner-sum r)))) ; Add a random value to each element in array
                  v'
                  (range 10000))] ; 10k outer loop iterations
    (println (nth v r)))) ; Print out a single element from the array

(main (-> *command-line-args* first parse-long))  ; Get an input number from the command line