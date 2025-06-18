(ns run
  (:require [languages.benchmark :as benchmark])
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

(defn- loops [^long u]
  (let [r (long (rand-int 10000)) ; Get a random number 0 <= r < 10k
        a (long-array 10000)] ; Array of 10k elements initialized to 0
    (loop [i 0]
      (when (< i 10000) ; 10k outer loop iterations
        (loop [j 0]
          (when (< j 10000) ; 10k inner loop iterations, per outer loop iteration
            (aset a i (unchecked-add (aget a i) (rem j u))) ; Simple sum
            (recur (unchecked-inc j))))
        (aset a i (unchecked-add (aget a i) r)) ; Add a random value to each element in array
        (recur (unchecked-inc i))))
    (aget a r)))

(defn -main [& args]
  (let [run-ms (parse-long (first args))
        warmup-ms (parse-long (second args))
        u (parse-long (nth args 2))
        _warmup (benchmark/run #(loops u) warmup-ms)]
    (-> (benchmark/run #(loops u) run-ms)
        benchmark/format-results
        println)))

(comment
  (-main "1" "0" "40")
  :rcf)
