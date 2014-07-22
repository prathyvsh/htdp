#lang racket
(require lang/htdp-intermediate)

;; mini : nelon  ->  number
;; to determine the smallest number
;; on alon
(define (mini1 alon)
  (find-extremes < alon))
     	
;; maxi : nelon  ->  number
;; to determine the largest number
;; on alon
(define (maxi1 alon)
  (find-extremes > alon))

;; mini : nelon  ->  number
;; to determine the smallest number
;; on alon
(define (improved-mini1 alon)
  (improved-extremes < alon))
     	
;; maxi : nelon  ->  number
;; to determine the largest number
;; on alon
(define (improved-maxi1 alon)
  (improved-extremes > alon))

;; find-extremes : operator list-of-numbers
;; Finds the extremes (either min or max) of the given
;; list of numbers
(define (find-extremes op alon)
  (cond
   [(empty? (rest alon)) (first alon)]
   [else (cond
          [(op (first alon) (find-extremes op (rest alon))) (first alon)]
          [else (find-extremes op (rest alon))])]))

(define (improved-extremes op alon)
  (cond
   [(empty? (rest alon)) (first alon)]
   [else (local ((define computed-extreme (find-extremes op (rest alon))))
            (pick-interesting op (first alon) computed-extreme))]))

;; pick-interesting : operator number number -> number
;; Picks the first number if th
(define (pick-interesting comparison-op num1 num2)
  (cond
   [(comparison-op num1 num2) num1]
   [else num2]))

(equal? (mini1 (list 3 7 6 2 9 8)) 2)
(equal? (maxi1 (list 3 7 6 2 9 8)) 9)

(equal? (mini1 (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)) 1)
(equal? (maxi1 (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)) 20)

(equal? (mini1 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)) 1)
(equal? (maxi1 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)) 20)

(equal? (improved-mini1 (list 3 7 6 2 9 8)) 2)
(equal? (improved-maxi1 (list 3 7 6 2 9 8)) 9)

(equal? (improved-mini1 (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)) 1)
(equal? (improved-maxi1 (list 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)) 20)

(equal? (improved-mini1 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)) 1)
(equal? (improved-maxi1 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)) 20)
