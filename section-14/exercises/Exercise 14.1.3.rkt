#lang racket
(require lang/htdp-beginner)

;; A family-tree is either
;; empty or
;; (make-child family-tree family-tree 'symbol number 'symbol)
(define-struct child (father mother name date eyes))

;; count-persons : family-tree -> number
;; Calculates the number of persons present in the family tree f-tree
(define (count-persons a-ftree)
  (cond
    [(empty? a-ftree) 0]
    [else (+ 1 (count-persons (child-father a-ftree))
             (count-persons (child-mother a-ftree)))]))

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

(= (count-persons Gustav) 5)
(= (count-persons Carl) 1)
