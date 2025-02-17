#lang racket

(require "../../lib/racket/benchmark.rkt"
         "loops.rkt")

(command-line
 #:args (run-ms-str warmup-ms-str u-str)
 (define run-ms (string->number run-ms-str))
 (define warmup-ms (string->number warmup-ms-str))
 (define u (string->number u-str))

 ;; Run a warmup (no status output if warmup-ms = 1)
 (run (λ () (loops u)) warmup-ms)
 ;; Run the benchmark and format the results.
 (define results (run (λ () (loops u)) run-ms))
 (displayln (format-results results)))
