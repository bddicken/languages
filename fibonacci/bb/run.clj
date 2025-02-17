(require '[languages.benchmark :as benchmark])
(require 'fibonacci)

(let [run-ms (parse-long (first *command-line-args*))
      ; skip warmup arg, because we skip warmups
      u (parse-long (nth *command-line-args* 2))]
  (-> (benchmark/run #(fibonacci/fibonacci u) run-ms)
      benchmark/format-results
      println))
