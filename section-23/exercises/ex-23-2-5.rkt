#lang racket
(require lang/htdp-intermediate)

;; arithmetic-series : N N -> (listof N)
(define (arithmetic-series start s)
  (local ((define (series-builder n)
  (+ start (* s n))))
    series-builder))


(define even (arithmetic-series 0 2))

;; TESTS
(equal? (build-list 4 even) (list 0 2 4 6))
