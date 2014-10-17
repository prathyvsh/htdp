#lang racket
(require lang/htdp-intermediate)

;; sort : list-of-numbers  ->  list-of-numbers
;; to construct a list with all items from alon in descending order
(define (sort-with-operator op alon)
  (local ((define (sort op alon)
	    (cond
	      [(empty? alon) empty]
	      [else (insert op (first alon) (sort op (rest alon)))]))
	  (define (insert op an alon)
	    (cond
	      [(empty? alon) (list an)]
	      [else (cond
		      [(op an (first alon)) (cons an alon)]
		      [else (cons (first alon) (insert op an (rest alon)))])])))
    (sort op alon)))


(sort-with-operator < (list 2 3 1 5 4))
(sort-with-operator > (list 2 3 1 5 4))
