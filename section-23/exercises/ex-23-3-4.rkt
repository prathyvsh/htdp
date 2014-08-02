#lang racket
(require lang/htdp-intermediate)

;; geometric-series : number number -> (number -> number)
;; Creates a geometric series
(define (geometric-series start s)
  (local ((define (g-series n)
    (* start (expt s n))))
  g-series))

(define g-fives (geometric-series 3 5))


;; TESTS
(equal? (build-list 5 g-fives) (list 3 15 75 375 1875))
