(ns fibonacci)

(set! *unchecked-math* :warn-on-boxed)

(definterface IFib
  (^long fib [^long n]))

(deftype Fibonacci []
  IFib
  (fib [_  n]
    (if (< n 2)
      (long n)
      (long (+ (.fib _ (- n 1))
               (.fib _ (- n 2)))))))

(def ^Fibonacci fib (Fibonacci.))