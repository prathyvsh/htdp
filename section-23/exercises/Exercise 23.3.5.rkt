#lang racket
(require lang/htdp-intermediate)

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

;; geometric-series : number number -> (number -> number)
;; Creates a geometric-series function
(define (geometric-series start s)
  (local ((define (g-series n)
    (* start (expt s n))))
  g-series))

(define g-fives (geometric-series 3 5))
(define g-one-tenth (geometric-series 1 .1))

;; TESTS
(series 3 g-fives)
(series 7 g-fives)
(series 88 g-fives)

(series 3 g-one-tenth)
(series 7 g-one-tenth)
(series 11 g-one-tenth)

;; Yes, a geometric series can have a sum if it converges to a number
;; Example 1 1/2 1/4 1/8 1/16
