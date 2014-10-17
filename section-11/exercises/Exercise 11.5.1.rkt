#lang racket
(require lang/htdp-beginner)

;; add: N N  ->  N
;; Adds n with x
(define (add n x)
  (cond
    [(zero? x) n]
    [else (add1 (add n (sub1 x)))]))

;; TESTS
(= (add 3 4) 7)
(= (add 100 20) 120)
(= (add 2 2) 4)
