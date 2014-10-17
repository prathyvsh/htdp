#lang racket
(require lang/htdp-advanced)

(define-struct node (name to))

;; A simple-graph-node (node) is a structure:
;; (make-node n t) 
;; where n is a symbol and t is a node.

;; create-node : symbol  ->  node
;; to create a simple graph node that contains a-name and itself
(define (create-node a-name)
  (local ((define the-node (make-node a-name false)))
    (begin
      (set-node-to! the-node the-node)
      the-node)))


(define A (create-node 'A))
(define B (create-node 'B))
(define C (create-node 'C))
(define D (create-node 'D))
(define E (create-node 'E))
(define F (create-node 'F))
(set-node-to! A B)
(set-node-to! B C)
(set-node-to! C E)
(set-node-to! D E)
(set-node-to! E B)
