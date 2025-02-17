(ns run
  (:require [languages.benchmark :as benchmark]
            [fibonacci])
  (:gen-class))

(defn -main [& args]
  (let [run-ms (parse-long (first args))
        warmup-ms (parse-long (second args))
        n (parse-long (nth args 2))
        _warmup (benchmark/run #(.fib fibonacci/fib n) warmup-ms)]
    (-> (benchmark/run #(.fib fibonacci/fib n) run-ms)
        benchmark/format-results 
        println)))

(comment
  (-main "3000" "2000" "37")
  :rcf)

