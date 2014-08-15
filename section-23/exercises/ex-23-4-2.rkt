#lang racket
(require lang/htdp-intermediate)

;; R : number of rectangles to approximate integral
(define R 10000)

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
   [(= n 0) (a-term n)]
   [else (+ (a-term n)
            (series (- n 1) a-term))]))
;; integrate : (number -> number) number number -> number
(define (integrate fn a b)
  (local ((define (ith-rectangle-area i)
            (local ((define width (/ (- b a) R))
                    (define step (/ width 2))
                    (define mid-term (+ a (* i width) step))
                    (define f-at-mid (fn mid-term))
                    (define area (abs (* width f-at-mid))))
              area)))
    (series (- R 1) ith-rectangle-area)))

;; TESTS
(define (constant x) 1)
(integrate constant 0 1)
(integrate constant 2 5)

(define (idempotent x) x)
(integrate idempotent 0 1)
(integrate idempotent 2 4)

(define (square x) (* x x))
(integrate square 0 1)
(integrate square 2 4)

(integrate sin 0 1) ; On increasing R, the function
                    ; seemingly becomes more accurate
