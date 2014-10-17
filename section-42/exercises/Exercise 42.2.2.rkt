#lang racket
(require lang/htdp-advanced)

(define-struct child (name social father mother))

;; equal-child : child child -> boolean
;; To determine if two children are extensionally equal
(define (eq-child c1 c2)
  (cond
   [(false? c1) (false? c2)]
   [(false? c2) false]
   [else 
  (local
      ((define c1-name (child-name c1))
       (define c2-name (child-name c2))
       (define same (begin (set-child-name! c1 'Tony)
                           (set-child-name! c2 'Markus)
                           (symbol=? (child-name c1) (child-name c2)))))
       (begin (set-child-name! c1 c1-name) (set-child-name! c2 c2-name) same))]))

;; TESTS
(define tom (make-child 'Tom 233 'George 'Mary))
(define tom2 (make-child 'Tom 233 'George 'Mary))
(define tom3 tom)

(eq-child tom tom)
(not (eq-child tom tom2))
(eq-child tom tom3)

;; For a family tree of m nodes and n nodes, the maximal abstract
;; running time is O(1)
