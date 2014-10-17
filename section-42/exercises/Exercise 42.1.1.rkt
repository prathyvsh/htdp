#lang racket
(require lang/htdp-advanced)

(define-struct child (name social father mother))

;; equal-child : child child -> boolean
;; To determine if two children are extensionally equal
(define (equal-child c1 c2)
  (cond
   [(empty? c1) (empty? c2)]
   [(empty? c2) false]
   [else 
  (and
   (symbol=? (child-name c1) (child-name c2))
   (= (child-social c1) (child-social c2))
   (equal-child (child-father c1) (child-father c2))
   (equal-child (child-mother c1) (child-mother c2)))]))

;; TESTS
(define george (make-child 'George 2 empty empty))
(define mary (make-child 'Mary 4 empty empty))
(define tom (make-child 'Tom 233 george mary))
(define tom2 (make-child 'Tom 233 george mary))

(equal-child tom tom)
(equal-child tom tom2)

;; For a family tree of m nodes and n nodes, the maximal abstract
;; running time is O(m + n)
