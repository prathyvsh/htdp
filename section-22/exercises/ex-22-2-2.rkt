#lang racket
(require lang/htdp-intermediate)

;; sort : list-of-numbers  ->  list-of-numbers
;; to construct a list with all items from alon in descending order
(define (build-sort op)
  (local ((define (sorter alon) (foldl insert empty alon))
	  (define (insert an alon)
	    (cond
	      [(empty? alon) (list an)]
	      [else (cond
		      [(op an (first alon)) (cons an alon)]
		      [else (cons (first alon) (insert an (rest alon)))])])))
    sorter))

(define asc-sort (build-sort <))
(define desc-sort (build-sort >))

;; TESTS
(equal? (asc-sort (list 3 9 2 4)) (list 2 3 4 9))
(equal? (desc-sort (list 3 9 2 4)) (list 9 4 3 2))
