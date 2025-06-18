(ns languages.benchmark)

(defn- stats
  "Returns stats in ms for input in ns"
  [total-elapsed-time elapsed-times]
  (let [runs (count elapsed-times)
        mean-ns (/ total-elapsed-time runs)
        min-ns (reduce min elapsed-times)
        max-ns (reduce max elapsed-times)
        variance (/ (reduce + (map (fn [t]
                                     (Math/pow (- t mean-ns) 2))
                                   elapsed-times))
                    runs)
        std-dev-ns (Math/sqrt variance)]
    {:mean-ms (/ mean-ns 1000000)
     :min-ms (/ min-ns 1000000)
     :max-ms (/ max-ns 1000000)
     :std-dev-ms (/ std-dev-ns 1000000)}))

; Avoid introducing more overhead than necessary in the loop below
(set! *unchecked-math* :warn-on-boxed) 

(defn run 
  "Runs `f` repeatedly measuring the time delta in nanoseconds
   Stops when the sum of the deltas is larger then `run-ms`
   Returns a map with stats and result.
   Special cases: When `run-ms` is: 0 => Don't run, `1` => this is a check-output correctness test 
   NB: If `f` takes sub-milliseconds to run, this function can run for very long
       because of the overhead of looping so many times."
  [f ^long run-ms]
  (when-not (zero? run-ms)
    (let [run-ns (* 1000000 run-ms)
          runs (binding [*out* *err*]
               ;; Start with printing a status dot, except if check-output run
                 (when (> run-ms 1) (print ".") (flush))
                 (loop [results []
                        last-tet 0
                        last-status-t (System/nanoTime)]
                   (let [t0 (System/nanoTime)
                         result (f)
                         t1 (System/nanoTime)
                         elapsed-time (- t1 t0)
                         total-elapsed-time (+ last-tet elapsed-time)
                         timed-result [total-elapsed-time elapsed-time result]
                         print-status? (and (> run-ms 1) ; Not if check-output run
                                            (> (- t0 last-status-t) 1000000000))]
                     (when print-status? (print ".") (flush))
                     (if (< total-elapsed-time run-ns)
                       (recur (conj results timed-result) total-elapsed-time (if print-status?
                                                                               t1
                                                                               last-status-t))
                       (do
                         (when (> run-ms 1) (println)) ; No status printed for check-output runs
                         (conj results timed-result))))))
          [^long total-elapsed-time _ ^long result] (last runs)
          elapsed-times (map second runs)]
      (merge {:runs (count runs)
              :result result}
             (stats total-elapsed-time elapsed-times)))))

(defn format-results [{:keys [mean-ms std-dev-ms min-ms max-ms runs result]}]
  (str (double mean-ms) "," (double std-dev-ms) "," (double min-ms) "," (double max-ms) "," runs "," result))

(comment
  (-> (run #(reduce + (range 1000000)) 1000)
      format-results)
  :rcf)

