#lang racket
(require lang/htdp-advanced)

                                        ; A binary-tree (short: BT) is either
                                        ; false or
                                        ; (make-node soc pn lft rgt) 
                                        ; where soc is a number, pn is a symbol, and lft and rgt are BTs.

(define-struct node (ssn name left right))

;; A binary tree is a binary search tree if every node structure
;; contains a social security number that is larger than all those
;; in the left subtree and smaller than all those in the right subtree.

(define (create-node name ssn)
  (local
      ((define tree (make-node ssn name empty empty))

       (define (insert! name ssn)
         (insert-bst! name ssn tree))

       ;; insert-bst! : symbol number bst -> void
       ;; Effect: Inserts a node in to the binary search tree
       ;; by preserving the order
       (define (insert-bst! name ssn bst)
         (local ((define left (node-left bst))
                 (define right (node-right bst))
                 (define current-ssn (node-ssn bst)))
           (cond
            [(<= ssn current-ssn) (cond
                                   [(empty? left) (set-node-left! bst (make-node ssn name empty empty))]
                                   [else (insert-bst! name ssn left)])]
            [else (cond
                   [(empty? right) (set-node-right! bst (make-node ssn name empty empty))]
                   [else (insert-bst! name ssn right)])])))

       ;; remove-bst! : number -> void
       ;; Effect: Removes the node with the given ssn
       (define (remove-bst! ssn) (cond
                                  [(empty? tree) empty]
                                  [(= ssn (node-ssn tree)) (begin (set! tree (shift-all-nodes tree)))]
                                  [else (remove-aux ssn tree)]))

       (define (remove-aux ssn bst)
         (cond
          [(empty? bst) false]
          [else
           (local ((define left (node-left bst))
                   (define right (node-right bst)))
             (cond
              [(and (empty? left) (empty? right)) (void)]
              [(has-ssn? ssn left) (set-node-left! bst (shift-all-nodes left))]
              [(has-ssn? ssn right) (set-node-right! bst (shift-all-nodes right))]
              [else (begin (remove-aux ssn left) (remove-aux ssn right))]))]))

       (define (has-ssn? ssn n)
         (cond
          [(empty? n) false]
          [else (= ssn (node-ssn n))]))


       ;; shift-all-nodes : binary-search-tree
       ;; Effect : Inserts all the nodes from the left to the right
       (define (shift-all-nodes n)
         (local ((define (insert-all from to)
                   (cond
                    [(empty? from) (void)]
                    [else (begin (insert-bst! (node-name from) (node-ssn from) to)
                                 (insert-all (node-left from) to)
                                 (insert-all (node-right from) to))])))
           (begin (insert-all (node-right n) (node-left n)) (node-left n))))

       (define (service-manager s)
         (cond
          [(symbol=? s 'insert) insert!]
          [(symbol=? s 'status) tree]
          [(symbol=? s 'remove) remove-bst!]
          [else (error 'create-node "Unknown message")])))
    service-manager))

;; TESTS
(define test-bst (create-node 'Seth 3))
((test-bst 'insert) 'Markus 2)
((test-bst 'insert) 'Fabio 9)
((test-bst 'insert) 'Ram 1)
((test-bst 'insert) 'Marco 7)
((test-bst 'insert) 'Lavina 10)

(equal? (test-bst 'status)
        (make-node 3 'Seth (make-node 2 'Markus (make-node 1 'Ram empty empty) empty)
                   (make-node 9 'Fabio (make-node 7 'Marco empty empty) (make-node 10 'Lavina empty empty))))

((test-bst 'remove) 9)

(equal? (test-bst 'status)
        (make-node 3 'Seth (make-node 2 'Markus (make-node 1 'Ram empty empty) empty) (make-node 7 'Marco empty (make-node 10 'Lavina empty empty))))

((test-bst 'remove) 3)
(equal? (test-bst 'status)
        (make-node 2 'Markus (make-node 1 'Ram empty empty) (make-node 7 'Marco empty (make-node 10 'Lavina empty empty))))

((test-bst 'remove) 1)
(equal? (test-bst 'status)
        (make-node 2 'Markus empty (make-node 7 'Marco empty (make-node 10 'Lavina empty empty))))

;; NOTE TO READER :
;; Not too satisfied with this solution
;; pretty sure a better approach can be
;; devised for the remove-bst! part
