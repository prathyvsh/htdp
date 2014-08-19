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

;; sum-tree : number-tree -> number
;; Calculates the sum of the number tree
(define (sum-tree tree)
  (cond
   [(number? tree) tree]
   [else (+ (sum-tree (first tree)) (sum-tree (second tree)))]))


;; tree-height : number-tree -> number
;; Calculates the height of the number tree
(define (tree-height tree)
  (cond
   [(number? tree) 1]
   [else (+ (tree-height (first tree)) (tree-height (second tree)))]))

;; TESTS
(equal? (sum-tree 5) 5)
(equal? (sum-tree 3) 3)
(equal? (sum-tree (list 5 3)) 8)
(equal? (sum-tree (list 5 (list 5 3))) 13)
(equal? (sum-tree (list 5 (list 5 (list 3 3)))) 16)

(equal? (tree-height 3) 1)
(equal? (tree-height (list 3 5)) 2)
(equal? (tree-height (list 5 (list 3 5))) 3)

;; For a tree with N elements, there is always (N - 1) calls to sum-tree and
;; tree-height
;; Hence the abstract running time of tree-height is of the order of N.
