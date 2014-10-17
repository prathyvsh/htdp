#lang racket
(require lang/htdp-beginner)

;; A family-tree is either
;; empty or
;; (make-child family-tree family-tree 'symbol number 'symbol)
(define-struct child (father mother name date eyes))

;; count-persons : family-tree number -> number
;; Calculates the average age of all people in the family tree
;; collect-eye-colors : family-tree number -> number
;; Collect eye colors of all members in the family tree
(define (proper-blue-eyed-ancestor? a-ftree)
  (cond
    [(empty? a-ftree) false]
    [else (or (blue-eyed-ancestor? (child-father a-ftree))
              (blue-eyed-ancestor? (child-mother a-ftree)))]))

;; blue-eyed-ancestor? : ftn  ->  boolean
;; to determine whether a-ftree contains a child
;; structure with 'blue in the eyes field
;; version 2: using an or-expression
(define (blue-eyed-ancestor? a-ftree)
  (cond
    [(empty? a-ftree) false]
    [else (or (symbol=? (child-eyes a-ftree) 'blue)
              (or (blue-eyed-ancestor? (child-father a-ftree))
                  (blue-eyed-ancestor? (child-mother a-ftree))))]))

;; TESTS
;; Oldest Generation:
(define Carl (make-child empty empty 'Carl 1926 'green))
(define Bettina (make-child empty empty 'Bettina 1926 'green))

;; Middle Generation: 
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Youngest Generation: 
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))

;; A friend uses proper-blue-eyed-ancestor itself on the family tree.
;; This results in false always since the end case for the recursion is
;; only met at the end of the stack at false.
(proper-blue-eyed-ancestor? Eva)
