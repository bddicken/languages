(ns code
  (:gen-class))

(set! *unchecked-math* :warn-on-boxed)

(defn- fibonacci ^long [^long n]
  ((fn fib ^long [^long n]
    (if (<= n 1)
      n
      (+ (long (fib (- n 1)))
         (long (fib (- n 2)))))) n))

(defn -main [& args]
  (let [u (long (parse-long (first args)))
        r (loop [i 1
                 sum 0]
            (if (< i u)
              (recur (inc i) (+ sum (long (fibonacci i))))
              sum))]
    (println r)))
