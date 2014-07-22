#lang racket
(require lang/htdp-intermediate)

#|
;; DATA DEFINITIONS
An inventory is either

empty or

(cons ir inv) 
where ir is an inventory record and inv is an inventory.
|#
(define-struct ir (name price))

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

;; <ir : IR IR  ->  boolean
(define (lesser-ir ir p) (< (ir-price ir) (ir-price p)))

;; <ir : IR IR -> boolean
(define (greater-ir ir p) (> (ir-price ir) (ir-price p)))

;; TESTS
(define inv1 (list (make-ir 'Doll 2.99) (make-ir 'Robot 13.99)))
(define inv2 (list (make-ir 'Barbie 7.99)
                   (make-ir 'Doll 2.49)
                   (make-ir 'Elephant 2.75)
                   (make-ir 'Robot 13.99)))

(equal? (sort-with-operator lesser-ir inv1)
        (list (make-ir 'Doll 2.99) (make-ir 'Robot 13.99)))
(equal? (sort-with-operator greater-ir inv1)
        (list (make-ir 'Robot 13.99)
              (make-ir 'Doll 2.99)))

(equal? (sort-with-operator lesser-ir inv2) (list (make-ir 'Doll 2.49)
                                                  (make-ir 'Elephant 2.75)
                                                  (make-ir 'Barbie 7.99)
                                                  (make-ir 'Robot 13.99)))
(equal? (sort-with-operator greater-ir inv2) (list (make-ir 'Robot 13.99)
                                                   (make-ir 'Barbie 7.99)
                                                   (make-ir 'Elephant 2.75)
                                                   (make-ir 'Doll 2.49)))
