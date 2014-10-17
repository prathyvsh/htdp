#lang racket
(require lang/htdp-intermediate-lambda)

;; id-vector : N -> vector
(define (id-vector n)
  (build-vector n (lambda (i) 1)))

;; TESTS
(equal? (id-vector 1) (vector 1))
(equal? (id-vector 2) (vector 1 1))
(equal? (id-vector 10) (vector 1 1 1 1 1 1 1 1 1 1))
