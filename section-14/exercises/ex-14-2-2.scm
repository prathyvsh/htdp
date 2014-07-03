;; A node is either
;; false or
;; (make-node number symbol binary-tree binary-tree)
(define-struct node (ssn name left right))

;; contains-bt : number binary-tree -> boolean
;; Determines if binary tree bt contains number
(define (contains-bt number bt)
  (cond
    [(false? bt) false]
    [else (or (= (node-ssn bt) number)
              (contains-bt number (node-left bt))
              (contains-bt number (node-right bt)))]))

;; search-bt : number binary-tree -> number or false
;; Searches binary tree for ssn number and returns person's name if found
(define (search-bt n bt)
  (cond
    [(false? bt) false]
    [(= (node-ssn bt) n) (node-name bt)]
    [(contains-bt n (node-left bt)) (search-bt n (node-left bt))]
    [else (search-bt n (node-right bt))]))


(define node1 (make-node 9 'Haridasan false false))
(define node2 (make-node 3 'Shiva node1 false))
(define node3 (make-node 12 'Ramachandran false node2))

#|
(Ramachandran false (Shiva (Haridasan) false))
|#

(search-bt 9 node1)
(search-bt 23 node1)
(search-bt 9 node2)
(search-bt 9 node3)
(search-bt 3 node2)
(search-bt 12 node3)
(search-bt 42 node1)
