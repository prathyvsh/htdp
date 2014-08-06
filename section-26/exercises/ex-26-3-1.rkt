#lang racket
(require lang/htdp-intermediate-lambda)

;; gcd-structural : N[>= 1] N[>= 1]  ->  N
;; to find the greatest common divisior of n and m
;; structural recursion using data definition of N[>= 1] 
(define (gcd-structural n m)
  (local ((define (first-divisior-<= i)
	    (cond
	      [(= i 1) 1]
	      [else (cond
		      [(and (= (remainder n i) 0) 
			    (= (remainder m i) 0))
		       i]
		      [else (first-divisior-<= (- i 1))])])))
    (first-divisior-<= (min m n))))

(time (gcd-structural 101135853 45014640))

#|
In core racket
cpu time: 824 real time: 823 gc time: 0

In intermediate language
cpu time: 2883 real time: 2880 gc time: 0
|#

