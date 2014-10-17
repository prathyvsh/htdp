#lang racket
(require lang/htdp-beginner)

;; A node is either
;; false or
;; (make-node number symbol binary-tree binary-tree)
(define-struct node (ssn name left right))


#|

;; TEMPLATE
(define (node-manip bt)
  (cond
    [(false? bt) ...]
    [else (... (node-ssn bt) ...)
          (... (node-name bt) ...)
          (... (node-manip (left bt)) ...)
          (... (node-manip (right bt)) ...)]))
|#

;; contains-bt : number binary-tree -> boolean
;; Determines if binary tree bt contains number
(define (contains-bt number bt)
  (cond
    [(false? bt) false]
    [else (or (= (node-ssn bt) number)
              (contains-bt number (node-left bt))
              (contains-bt number (node-right bt)))]))

(define node1 (make-node 9 'Haridasan false false))
(define node2 (make-node 3 'Shiva node1 false))
(define node3 (make-node 12 'Ramachandran false node2))

#|
(Ramachandran false (Shiva (Haridasan) false))
|#

(boolean=? (contains-bt 9 node1) true)
(boolean=? (contains-bt 23 node1) false)
(boolean=? (contains-bt 9 node2) true)
(boolean=? (contains-bt 9 node3) true)
(boolean=? (contains-bt 3 node2) true)
(boolean=? (contains-bt 42 node1) false)
