#lang racket
(require lang/htdp-intermediate)

;; ! : N  ->  number
(define (! n)
  (cond
   [(= n 0) 1]
   [else (* n (! (sub1 n)))]))

(define (e-power x)
  (local ((define (e-taylor i)
	    (/ (expt x i) (! i)))
	  (define (! n)
	    (cond
             [(= n 0) 1]
             [else (* n (! (sub1 n)))])))
    (series 5 e-taylor)))

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
   [(= n 0) (a-term n)]
   [else (+ (a-term n)
            (series (- n 1) a-term))]))

;; Determining precision
(- (exp 1) (exact->inexact (e-power 1)))

#|
;; EVALUATION
(e-power 1)
(local ((define (e-taylor i)
          (/ (expt 1 i) (! i)))
        (define (! n)
          (cond
           [(= n 0) 1]
           [else (* n (! (sub1 n)))])))
  (series 3 e-taylor)))

(series 3 e-taylor)

(cond
 [(= 3 0) (e-taylor 3)]
 [else (+ (e-taylor 3)
          (series (- 3 1) e-taylor))])

(+ (e-taylor 3) (series 2 e-taylor))

(+ (/ (expt 1 3) (! 3)) (series 2 e-taylor))

(+ (/ 1 6) (series 2 e-taylor))

(+ 1/6 (series 2 e-taylor))

(+ 1/6 (/ (expt 1 2) (! 2)) (series 1 e-taylor))

(+ 1/6 (/ 1 4) (series 1 e-taylor))

(+ 1/6 1/4 (series 1 e-taylor))

(+ 1/6 1/4 (/ (expt 1 1) (! 1)) (series 0 e-taylor))

(+ 1/6 1/4 1/1 (expt 1 0) (! 0))

(+ 1/6 1/4 1 1)

2.416667
|#
