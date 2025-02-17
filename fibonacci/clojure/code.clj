(ns code
  (:require [languages.benchmark :as benchmark]
            [fibonacci])
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

(defn -main [& args]
  (let [u (long (parse-long (first args)))
        r (loop [i 1
                 sum 0]
            (if (< i u)
              (recur (inc i) (+ sum (long (.fib fibonacci/fib i))))
              sum))]
    (println r)))
