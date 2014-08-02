#lang racket
(require lang/htdp-intermediate)

;; g-fives : N -> N
;; Determines the n-th digit of arithmetic sequence
(define (g-fives n)
  (cond
   [(= n 0) 3]
   [else (* 5 (g-fives (sub1 n)))]))

;; TESTS
(equal? (g-fives 0) 3)
(equal? (g-fives 1) 15)
(equal? (g-fives 2) 75)
(equal? (g-fives 3) 375)
