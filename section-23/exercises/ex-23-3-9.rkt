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

(define (greg iterations)
  ;; greg-term : number -> number
  ;; Generates the ith element in the Gregory series
  (local ((define (greg-term i)
            (local ((define sign
                      (cond
                       [(= (remainder i 2) 0) 1]
                       [else -1]))
                    (define odd-term (make-odd i)))
              (* (/ 1 odd-term) sign))))
    (* 4 (series iterations greg-term))))

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
   [(= n 0) (a-term n)]
   [else (+ (a-term n)
            (series (- n 1) a-term))]))

;; TESTS
(- (exact->inexact (greg 1)) pi)
(- (exact->inexact (greg 2)) pi)
(- (exact->inexact (greg 3)) pi)
(- (exact->inexact (greg 4)) pi)
(- (exact->inexact (greg 5)) pi)
(- (exact->inexact (greg 10)) pi)
(- (exact->inexact (greg 100)) pi)
