#lang racket
(require lang/htdp-intermediate)

;; build-fold : (X Y -> X) -> (X
;; Combines each element of the alon using fn
(define (build-fold fn base)
  (local ((define (fold alon)
            (cond
             [(empty? alon) base]
             [else (fn (first alon) (fold (rest alon)))])))
    fold))

;; sum : (listof number)  ->  number
;; to compute the sum of alon
(define (sum alon)
  (local ((define summer (build-fold + 0)))
    (summer alon)))
     	
;; product : (listof number)  ->  number
;; to compute the product of alon
(define (product alon)
  (local ((define multiplier (build-fold * 1)))
  (multiplier alon)))

;; TESTS
(equal? (sum (list 1 2 3 4 5)) 15)
(equal? (product (list 1 2 3 4 5)) 120)
