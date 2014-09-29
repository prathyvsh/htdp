#lang racket
(require lang/htdp-advanced)

(define-struct child (name social father mother))

;; equal-child : child child -> boolean
;; To determine if two children are extensionally equal
(define (eq-child c1 c2) (int-eq-struct? c1 c2))

;; eq-posn : posn posn  ->  boolean
;; to determine whether two posn structures 
;; are affected by the same mutation 
(define (eq-posn p1 p2) (int-eq-struct? p1 p2))

;; int-eq-struct? : structure structure -> boolean
;; Determines if the two given structures are
;; intensionally equal
(define (int-eq-struct? str1 str2) (eq? str1 str2))

;; TESTS
(define tom (make-child 'Tom 233 'George 'Mary))
(define tom2 (make-child 'Tom 233 'George 'Mary))
(define tom3 tom)
(define p (make-posn 3 4))
(define p2 (make-posn 3 4))
(define p3 p2)

(eq-child tom tom)
(not (eq-child tom tom2))
(eq-child tom tom3)

(eq-posn p p)
(not (eq-posn p p2))
(eq-posn p2 p3)

;; For a family tree of m nodes and n nodes, the maximal abstract
;; running time is O(1)
