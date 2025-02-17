#lang racket

(require "../../lib/racket/benchmark.rkt"
         "fibonacci.rkt")

(command-line
 #:args (run-ms-str warmup-ms-str n-str)
 (define run-ms (string->number run-ms-str))
 (define warmup-ms (string->number warmup-ms-str))
 (define n (string->number n-str))

 ;; Run a warmup (no status output if warmup-ms = 1)
 (run (λ () (fibonacci n)) warmup-ms)
 ;; Run the benchmark and format the results.
 (define results (run (λ () (fibonacci n)) run-ms))
 (displayln (format-results results)))
