;; A node is either
;; false or
;; (make-node number symbol binary-tree binary-tree)
(define-struct node (soc name left right))

;; A list-of-number/name is either
;; empty or
;; (cons (list number symbol) list-of-number/name)

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


;; create-bst-from-list : list-of-numbers -> binary-search-tree
(define (create-bst-from-list lonn)
  (cond
  [(empty? lonn) false]
  [else (create-bst (create-bst-from-list (rest lonn))
                    (first (first lonn))
                    (second (first lonn)))]))

(define sample
  '((99 o) (77 l) (24 i) (10 h) (95 g) (15 d) (89 c) (29 b) (63 a)))
;; inorder : binary-tree -> list-of-ssn
;; Creates a list from the binary tree bt in a left node - current node - right node fashion
(define (inorder bt)
  (cond
    [(false? bt) empty]
    [else (append (inorder (node-left bt))
                  (list (node-soc bt))
                  (inorder (node-right bt)))]))

(inorder (create-bst-from-list sample))
