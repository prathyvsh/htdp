#lang racket
(require lang/htdp-advanced)

(define-struct child (name social father mother))

;; equal-child : child child -> boolean
;; To determine if two children are extensionally equal
(define (equal-child c1 c2) (equal-struct? c1 c2))

;; equal-posn : posn posn  ->  boolean
;; to determine whether two posns are extensionally equal 
(define (equal-posn p1 p2) (equal-struct? p1 p2))

;; equal-struct? : structure structure -> boolean
;; To determine if two structures are extensionally equal
(define (equal-struct? str1 str2)
  (equal? str1 str2))

;; TESTS
(define child1 (make-child 'Tom 234 'George 'Mary))
(define child2 (make-child 'Tom 234 'George 'Mary))
(define p1 (make-posn 3 6))
(define p2 (make-posn 3 6))
(equal-child child1 child2)
(equal-posn p1 p2)
(not (equal-posn p1 child1))

