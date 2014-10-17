#lang racket
(require lang/htdp-intermediate-lambda)

;; sum : (listof number)  ->  number
;; to compute the sum of the numbers on alon
;; structural recursion 
(define (sum alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon) (sum (rest alon)))]))

;; sum : (listof number)  ->  number
;; to compute the sum of the numbers on alon0
(define (sum-acc alon0)
  (local (;; accumulator is the sum of the numbers that preceded
	  ;; those in alon on alon0
	  (define (sum-a alon accumulator)
	    (cond
	      [(empty? alon) accumulator]
	      [else (sum-a (rest alon) (+ (first alon) accumulator))])))
    (sum-a alon0 0)))

(define (g-series n)
  (cond
    [(zero? n) empty]
    [else (cons (expt -0.99 n) (g-series (sub1 n)))]))

(sum (g-series #i1000))
(sum-acc (g-series #i1000))

(* 10e15 (sum (g-series #i1000)))
(* 10e15 (sum-acc (g-series #i1000)))

