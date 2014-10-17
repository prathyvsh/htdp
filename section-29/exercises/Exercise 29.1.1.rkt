#lang racket
(require lang/htdp-intermediate-lambda)

;; A number tree is either
;; a number or a pair of number trees.

;; Examples
;; 5
;; 3
;; (list 5 3)
;; (list 5 (list 5 3))
;; (list (list 5 3) (list 5 3))
;; (list 3 (list (list 5 (list (list 3 (list 5 3)) 3)) 5))

(define-struct tree (left right))


;; sum-tree : number-tree -> number
;; Calculates the sum of the number tree
(define (sum-tree tree)
  (cond
   [(number? tree) tree]
   [else (+ (sum-tree (first tree)) (sum-tree (second tree)))]))


;; tree-height : number-tree -> number
;; Calculates the height of the number tree
(define (tree-height t)
  (cond
   [(number? t) 0]
   [else (+ 1 (max (tree-height (tree-left t)) (tree-height (tree-right t))))]))

;; TESTS
;(equal? (sum-tree 5) 5)
;(equal? (sum-tree 3) 3)
;(equal? (sum-tree (list 5 3)) 8)
;(equal? (sum-tree (list 5 (list 5 3))) 13)
;(equal? (sum-tree (list 5 (list 5 (list 3 3)))) 16)

(equal? (tree-height 3) 0)
(equal? (tree-height (make-tree 3 5)) 1)
(equal? (tree-height (make-tree 5 (make-tree 3 5))) 2)
(equal? (tree-height (make-tree 3 (make-tree 5 (make-tree 3 5)))) 3)
(tree-height (make-tree 3 (make-tree (make-tree 4 (make-tree 6 4)) 5)))
(equal? (tree-height (make-tree 3 (make-tree (make-tree 5 (make-tree (make-tree 3 (make-tree 5 3)) 3)) 5))) 4)

;; For a tree with N levels,
;; if the tree is evenly divided,
;; there's always 2 * N calls. But if
;; a tree is lopsided, it leads to only N calls.
;; Although, if we consider N as the number of
;; elements, there's always (N - 1) calls to
;; sum-tree and tree-height. Hence the abstract
;; running time of tree-height is of the order of N.
