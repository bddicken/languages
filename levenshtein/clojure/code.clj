(ns code
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

(defn levenshtein-distance
  "Calculates and returns the Levenshtein distance between `s1` and `s2` using an optimized
  version of Wagner-Fischer algorithm that uses O(min(m,n)) space."
  ^long [^String s1 ^String s2]
  ;; Optimize by ensuring s1 is the shorter string to minimize space usage
  (let [[^String s1 ^String s2] (if (> (count s1) (count s2)) [s2 s1] [s1 s2])
        m (int (count s1))
        n (int (count s2))
        ;; Only need two rows for the dynamic programming matrix
        prev (long-array (inc m))
        curr (long-array (inc m))]
    ;; Initialize the first row
    (dotimes [i (inc m)]
      (aset prev i i))
    ;; Fill the matrix row by row
    (dotimes [i n]
      (aset curr 0 (inc i))
      (dotimes [j m]
        ;; Calculate cost - 0 if characters are same, 1 if different
        (let [cost (if (= (.charAt s1 j) (.charAt s2 i)) 0 1)
              ;; Calculate minimum of deletion, insertion, and substitution
              del (inc (aget prev (inc j)))
              ins (inc (aget curr j))
              sub (+ (aget prev j) cost)]
          (aset curr (inc j) (min del (min ins sub)))))
      ;; Swap rows
      (System/arraycopy curr 0 prev 0 (inc m)))
    (aget prev m)))

(defn -main
  "Main method that processes command line arguments and finds the minimum
  Levenshtein distance between any pairing of the input strings."
  [& args]
  (let [strings (vec args)
        n (count strings)
        distances (for [i (range n)
                        j (range n)
                        :when (not= i j)]
                    (levenshtein-distance (nth strings i) (nth strings j)))
        min-distance (apply min distances)]
    (println "times:" (* n (dec n)))
    (println "min_distance:" min-distance)))