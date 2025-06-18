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

(defn main
  "Main method that processes command line arguments and finds the minimum
  Levenshtein distance between any pair of input strings."
  [& args]
  (let [strings (vec args)
        n (count strings)
        distances (for [i (range n)
                        j (range n)
                        :when (not= i j)]
                    (levenshtein-distance (nth strings i) (nth strings j)))
        min-distance (apply min distances)]
    (println "times:" (count distances))
    (println "min_distance:" min-distance)))

(when (= *file* (System/getProperty "babashka.file"))
  (apply main *command-line-args*))

(comment
  (time
   (main "abcde" "abdef" "ghijk" "gjkl" "mno" "pqr" "stu" "vwx" "yz" "banana" "oranges"))
  ;; times: 110
  ;; min_distance: 2
  ;; "Elapsed time: 1.320292 msecs"
  (def words (clojure.string/split (slurp "levenshtein/input.txt") #"\s+"))
  (time (apply main words))
  ;; times: 2756
  ;; min_distance: 1
  ;; "Elapsed time: 2036.506417 msecs"
  :rcf)

