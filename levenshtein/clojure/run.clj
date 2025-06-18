(ns run
  (:require
   [clojure.string :as string]
   [languages.benchmark :as benchmark]
   [levenshtein])
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

(defn -main [& args]
  (let [run-ms (parse-long (first args))
        warmup-ms (parse-long (second args))
        input-path (nth args 2)
        strings (-> (slurp input-path)
                    (string/split-lines))
        _warmup (benchmark/run #(levenshtein/distances strings) warmup-ms)
        results (benchmark/run #(levenshtein/distances strings) run-ms)]
    (-> results
        (update :result (partial reduce +))
        benchmark/format-results
        println)))

(comment
  (-main "2000" "1000" "levenshtein-words.txt")
  :rcf)

