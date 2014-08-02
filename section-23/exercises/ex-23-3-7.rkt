#lang racket
(require lang/htdp-intermediate)

;; make-odd : number -> number
;; Gets the ith odd number
(define (make-odd i)
  (+ (* 2 i) 1))

;; ln-value : number -> number
;; Generates the taylor series for logarithm
(define (ln-value x)
  (local ((define (ln-taylor i)
            (local ((define odd-term (make-odd i)))
            (* (/ 2 odd-term) (expt (/ (sub1 x) (add1 x)) odd-term)))))
    (series 10 ln-taylor)))

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
   [(= n 0) (a-term n)]
   [else (+ (a-term n)
            (series (- n 1) a-term))]))

;; TESTS
(- (log 1) (exact->inexact (ln-value 1)))
(- (log 2) (exact->inexact (ln-value 2)))
(- (log 3) (exact->inexact (ln-value 3)))
(- (log 4) (exact->inexact (ln-value 4)))
(- (log 5) (exact->inexact (ln-value 5)))
(- (log 6) (exact->inexact (ln-value 6)))
