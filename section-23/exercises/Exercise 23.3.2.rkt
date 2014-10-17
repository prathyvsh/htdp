#lang racket
(require lang/htdp-intermediate)

;; g-fives : N -> N
;; Determines the n-th digit of arithmetic sequence
(define (g-fives-closed n)
  (* 3 (expt 5 n)))

;; TESTS
(equal? (g-fives-closed 0) 3)
(equal? (g-fives-closed 1) 15)
(equal? (g-fives-closed 2) 75)
(equal? (g-fives-closed 3) 375)
