(require '[languages.benchmark :as benchmark]
         ' [clojure.string :as string])

(defn levenshtein-distance
  "Calculates the Levenshtein distance between two strings using a functional approach."
  [s1 s2]
  (let [m (count s1)
        n (count s2)]
    ;; Create a matrix to store distances
    (as-> (vec (map vec (repeat (inc m) (repeat (inc n) 0)))) matrix
      ;; Initialize first row and column
      (reduce (fn [matrix i] (assoc-in matrix [i 0] i)) matrix (range (inc m)))
      (reduce (fn [matrix j] (assoc-in matrix [0 j] j)) matrix (range (inc n)))
      ;; Compute Levenshtein distance
      (reduce (fn [matrix i]
                (reduce (fn [matrix j]
                          (let [cost (if (= (nth s1 (dec i)) (nth s2 (dec j))) 0 1)]
                            (assoc-in matrix [i j]
                                      (min
                                       (inc (get-in matrix [(dec i) j]))              ;; Deletion
                                       (inc (get-in matrix [i (dec j)]))              ;; Insertion
                                       (+ (get-in matrix [(dec i) (dec j)]) cost))))) ;; Substitution
                        matrix (range 1 (inc n))))
              matrix (range 1 (inc m)))
      (get-in matrix [m n]))))

(defn levenshtein-distances
  "Return distances for all `words` pairings"
  [words]
  (let [n (count words)]
    (doall
     (for [i (range n)
           j (range n)
           :when (< i j)]
       (levenshtein-distance (nth words i) (nth words j))))))

(when (= *file* (System/getProperty "babashka.file"))
  (let [run-ms (parse-long (first *command-line-args*))
        ; skip warmup arg, because we skip warmups
        input-path (nth *command-line-args* 2)
        strings (-> (slurp input-path)
                    (string/split-lines))
        results (benchmark/run #(levenshtein-distances strings) run-ms)]
    (-> results
        (update :result (partial reduce +))
        benchmark/format-results
        println)))

(comment
  (time
   (reduce + (levenshtein-distances ["abcde" "abdef" "ghijk" "gjkl" "mno" "pqr" "stu" "vwx" "yz" "banana" "oranges"])))
  ;; => 265
  ;; "Elapsed time: 1.320292 msecs"
  (def words (string/split (slurp "../levenshtein-words.txt") #"\s+"))
  (time (reduce + (levenshtein-distances words)))
  ;; => 554324
  ;; "Elapsed time: 23758.768542 msecs"
  (-> (benchmark/run #(levenshtein-distances words) 1000)
      (update :result (partial reduce +))) 
  #_ {:max-ms 11954462271/500000,
      :mean-ms 11954462271/500000,
      :min-ms 11954462271/500000,
      :result 554324,
      :runs 1,
      :std-dev-ms 0.0}
  :rcf)

