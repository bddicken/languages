(require 'fibonacci)

(defn main [u]
  (println (reduce + (map fibonacci/fibonacci (range u)))))

(main (-> *command-line-args* first parse-long))