#lang racket
(require lang/htdp-intermediate)

;; make-value : N -> N
(define (make-value n)
  (+ 8 (* 5 n)))

;; a-fives-closed : N -> N
(define (a-fives-closed n)
  (make-value n))

;; TESTS
(equal? (a-fives 0) 8)
(equal? (a-fives 1) 13)
(equal? (a-fives 2) 18)
(equal? (a-fives 3) 23)
