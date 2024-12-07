(ns code
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

(defn -main [& args]
  (let [u (long (parse-long (first args))) ; Get an input number from the command line
        r (long (rand-int 10000)) ; Get a random number 0 <= r < 10k
        a (long-array 10000)] ; Array of 10k elements initialized to 0
    (loop [i 0]
      (when (< i 10000) ; 10k outer loop iterations
        (loop [j 0]
          (when (< j 100000) ; 100k inner loop iterations, per outer loop iteration
            (aset a i (unchecked-add (aget a i) (rem j u))) ; Simple sum
            (recur (unchecked-inc j))))
        (aset a i (unchecked-add (aget a i) r)) ; Add a random value to each element in array
        (recur (unchecked-inc i))))
    (println (aget a r)))) ; Print out a single element from the array
