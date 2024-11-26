(ns build
  (:require
   [clojure.tools.build.api :as b]))


(def lib 'benchmark.code)
(def class-dir "classes")
(def version "0.1")

(defn make-opts [opts]
  (assoc opts
    :lib lib
    :version version
    :basis (b/create-basis {})
    :jar-file "code.jar"
    :class-dir class-dir
    :src-dirs ["src"]
    :uber-file "code.jar"
    :main 'code))

(defn jar [opts]
  (let [opts (make-opts opts)]
    (b/delete {:path class-dir})
    (b/delete {:path "code.jar"})
    (b/copy-dir {:src-dirs ["src"]
                 :target-dir class-dir})
    (b/compile-clj opts)
    (b/uber opts)))
