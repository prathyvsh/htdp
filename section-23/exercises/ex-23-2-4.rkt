#lang racket
(require lang/htdp-intermediate)

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))

;; make-value : N -> N
(define (make-value n)
  (+ 8 (* 5 n)))

;; TESTS
(series 3 make-value)
(series 7 make-value)
(series 88 make-value)
