#lang racket
(require lang/htdp-intermediate)

;; sum : (listof number)  ->  number
;; to compute the sum of 
;; the numbers on alon
(define (sum alon)
  (fold 0 + alon))
     	
;; product : (listof number)  ->  number
;; to compute the product of 
;; the numbers on alon
(define (product alon)
  (fold 1 * alon))

;; fold : X (X -> X) (listof X) -> X
;; Performs a function repetitively on an element
;; and combines it on to a single output
(define (fold init fn alon)
  (cond
   [(empty? alon) init]
   [else (fn (first alon) (fold init fn (rest alon)))]))

;; append : (listof X) (listof X) -> (listof X)
;; Joins two lists together
(define (append1 l1 l2)
  (fold l2 cons l1))

;; map : (X -> Y) (listof X) -> (listof Y)
;; Maps fn on every value of list
(define (map1 fn list)
  (local ((define (cons-and-apply x y)
                    (cons (fn x) y)))
  (fold empty cons-and-apply list)))


(map1 sqr (list 3 4 5))

;; append : 
;; TESTS
(define nat5 (list 1 2 3 4 5))
(define random-nats (list 20 30 10))

(equal? (sum nat5) 15)
(equal? (product nat5) 120)
(equal? (sum random-nats) 60)
(equal? (product random-nats) 6000)
(equal? (append1 (list 1 2 3) (list 4 5 6 7 8))
        (list 1 2 3 4 5 6 7 8))
