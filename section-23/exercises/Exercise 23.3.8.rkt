#lang racket
(require lang/htdp-intermediate)

;; make-odd : number -> number
;; Gets the ith odd number
(define (make-odd i)
  (+ (* 2 i) 1))

;; ! : N  ->  number
(define (! n)
  (cond
   [(= n 0) 1]
   [else (* n (! (sub1 n)))]))


;; my-sin : number -> number
;; Generates the taylor series for sine function
(define (my-sin x)
  (local ((define (sin-term i)
            (local ((define sign
                      (cond
                       [(= (remainder i 2) 0) 1]
                       [else -1]))
                    (define odd-term (make-odd i)))
              (* (/ (expt x odd-term) (! odd-term)) sign))))
    (series 10 sin-term)))

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
   [(= n 0) (a-term n)]
   [else (+ (a-term n)
            (series (- n 1) a-term))]))

;; TESTS
(- (sin 1) (exact->inexact (my-sin 1)))
(- (sin 2) (exact->inexact (my-sin 2)))
(- (sin 3) (exact->inexact (my-sin 3)))
(- (sin 4) (exact->inexact (my-sin 4)))
(- (sin pi) (exact->inexact (my-sin pi)))
(- (sin 6) (exact->inexact (my-sin 6)))
