#lang racket
(require lang/htdp-intermediate)

;; g-fives : N -> N
;; Determines the n-th digit of arithmetic sequence
(define (a-fives n)
  (cond
   [(= n 0) 8]
   [else (+ 5 (a-fives (sub1 n)))]))

;; TESTS
(equal? (a-fives 0) 8)
(equal? (a-fives 1) 13)
(equal? (a-fives 2) 18)
(equal? (a-fives 3) 23)
