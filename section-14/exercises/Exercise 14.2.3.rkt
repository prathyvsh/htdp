#lang racket
(require lang/htdp-beginner)

;; A node is either
;; false or
;; (make-node number symbol binary-tree binary-tree)
(define-struct node (ssn name left right))

;; inorder : binary-tree -> list-of-ssn
;; Creates a list from the binary tree bt in a left node - current node - right node fashion
(define (inorder bt)
  (cond
    [(false? bt) empty]
    [else (append (inorder (node-left bt))
                  (list (node-ssn bt))
                  (inorder (node-right bt)))]))

;; TESTS
(define carl (make-node 87 'Carl false false))
(define john (make-node 24 'John false false))
(define gustav (make-node 15 'Gustav carl john))
(define mark (make-node 29 'Mark gustav false))
(define james (make-node 99 'James false false))
(define bob (make-node 95 'Bob false james))
(define andrew (make-node 33 'Andrew false false))
(define josh (make-node 89 'Josh andrew bob))
(define tim (make-node 63 'Tim mark josh))

(inorder tim)

;; Inorder produces a ascendingly sorted list for a binary search
;; tree.
