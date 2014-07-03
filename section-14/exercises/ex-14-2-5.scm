;; A node is either
;; false or
;; (make-node number symbol binary-tree binary-tree)
(define-struct node (soc name left right))

;; create-bst : binary-search-tree number symbol -> binary-search-tree
;; Creates a BST from b n and s
(define (create-bst b n s)
  (cond
    [(false? b) (make-node n s false false)]
    [else (cond
            [(< n (node-soc b)) (make-node 
                                  (node-soc b)
                                  (node-name b)
                                  (create-bst (node-left b) n s)
                                  (node-right b))]
            [(> n (node-soc b)) (make-node 
                                  (node-soc b)
                                  (node-name b)
                                  (node-left b)
                                  (create-bst (node-right b) n s))]
            [else (error 'create-bst "Same Social Number Present in Binary Search Tree")])]))

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

(create-bst
  (create-bst
    (create-bst
      (create-bst
        (create-bst
            (create-bst
              (create-bst
                (create-bst
                  (create-bst
                    false
                    63 'Tim)
                  89 'Josh)
                77 'Andrew)
              29 'Mark)
            15 'Gustav)
        95 'Bob)
      10 'Carl)
    24 'John)
  99 'James) "should be" tim
