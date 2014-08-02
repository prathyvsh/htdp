#lang racket
(require lang/htdp-intermediate)

;; make-even : N  ->  N[even]
;; to compute the i-th even number
(define (make-even i)
  (* 2 i))
            	
;; make-odd : N  ->  N[odd]
;; to compute the i-th odd number
(define (make-odd i)
  (+ (* 2 i) 1))

;; series-even1 : N  ->  number
(define (series-even1 n)
  (series n make-even))	
     	
;; series-odd1 : N  ->  number
(define (series-odd1 n)
  (series n make-odd))

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))


(define (series-local fn)
  (local ((define (series-builder n)
          (cond
           [(= n 0) (fn n)]
           [else (+ (fn n) (series-builder (- n 1)))])))
    series-builder))

;; TESTS
(define even-series (series-local make-even))
(define odd-series (series-local make-odd))
(equal? (series-even1 2) (even-series 2))
(equal? (series-odd1 3) (odd-series 3))

;; HAND EVALUATION

(series-local make-even)

  (local ((define (series-builder n)
          (cond
           [(= n 0) (make-even n)]
           [else (+ (make-even n) (series-builder (- n 1)))])))
    series-builder)

(define (series-even2 n)
(cond
 [(= n 0) (make-even n)]
 [else (+ (make-even n) (series-even2 (- n 1)))])) ; QED
