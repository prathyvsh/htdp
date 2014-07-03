;; A node is either
;; false or
;; (make-node number symbol binary-tree binary-tree)
(define-struct node (soc name left right))

;; search-bst : number binary-tree -> symbol or false
;; Takes in a number and produces the name of the person with that social
;; number. Makes use of the fact that the tree is a binary search tree.
(define (search-bst n bst)
  (cond
    [(false? bst) false]
    [else (cond
            [(= n (node-soc bst)) (node-name bst)]
            [(> (node-soc bst) n) (search-bst n (node-left bst))]
            [(< (node-soc bst) n) (search-bst n (node-right bst))]
            [else false])]))

;; TESTS
(define carl (make-node 10 'Carl false false))
(define john (make-node 24 'John false false))
(define gustav (make-node 15 'Gustav carl john))
(define mark (make-node 29 'Mark gustav false))
(define james (make-node 99 'James false false))
(define bob (make-node 95 'Bob false james))
(define andrew (make-node 77 'Andrew false false))
(define josh (make-node 89 'Josh andrew bob))
(define tim (make-node 63 'Tim mark josh))

(symbol=? (search-bst 10 tim) 'Carl)
(symbol=? (search-bst 29 tim) 'Mark)
(symbol=? (search-bst 95 tim) 'Bob)
(boolean=? (symbol=? (search-bst 15 tim) 'Carl) false)

#|
;; Searching sorted list
[10 15 24 29 63 77 89 95 99]
Searching for 99 takes 9 tries.

;; Searching binary search tree
Searching for 99
63 = 99?
right
88 = 99?
right
95 = 99?
right
99 = 99?
true

Takes only 4 tries.
|#
