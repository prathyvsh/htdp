#lang racket
(require lang/htdp-advanced)

(define-struct person (name date father mother children))

;; A family-tree-node is either
;; false or
;; a person

;; A person is a structure:
;; (make-person n s f m c)
;; where n is a symbol, s is number, f and m are ftns, and c is a (listof person)

;; false represents missing information about a portion of the family tree.

;; add-child! : symbol number ftn ftn  ->  person
;; to construct a person structure for a newborn 
;; effect: to add the new structure to the children of father and mother
(define (add-child! name date father mother)
  (local ((define the-child
	    (make-person name date father mother empty))
          (define (has-father? c) (not (false? (person-father c))))
          (define (has-mother? c) (not (false? (person-mother c)))))
    (begin
      (if (has-father? the-child) (set-person-children! father (cons the-child (person-children father))) (void))
      (if (has-mother? the-child) (set-person-children! mother (cons the-child (person-children mother))) (void))
      the-child)))

;; TESTS

;; First generation
(define carl (add-child! 'Carl 1926 false false))
(define bettina (add-child! 'Bettina 1926 false false))

;; Second generation
(define adam (add-child! 'Adam 1950 carl bettina))
(define dave (add-child! 'Dave 1950 carl bettina))
(define eva (add-child! 'Eva 1950 carl bettina))
(define fred (add-child! 'Fred 1950 false false))

;; Third generation
(define gustav (add-child! 'Gustav 1950 eva fred))

gustav
