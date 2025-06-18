#lang racket

(require "../../lib/racket/benchmark.rkt"
         "levenshtein.rkt")

(command-line
 #:args (run-ms-str warmup-ms-str words-path)
 (define run-ms (string->number run-ms-str))
 (define warmup-ms (string->number warmup-ms-str))
 (define words (file->lines words-path))

 ;; Run a warmup (no status output if warmup-ms = 1)
 (run (λ () (levenshtein-distances words)) warmup-ms)
 ;; Run the benchmark and format the results.
 (define the-results (run (λ () (levenshtein-distances words)) run-ms))
 (define total-distance (for/sum ([distance (in-list (results-result the-results))])
                          distance))
 (displayln (format-results (struct-copy results the-results [result total-distance]))))
