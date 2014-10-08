(define-struct person (name social father mother children))

;; A family-tree-node is either
;; false or
;; a person

;; A person is a structure:
;; (make-person n s f m c)
;; where n is a symbol, s is number, f and m are ftns, and c is a (listof person)

;; false represents missing information about a portion of the family tree.

;; add-child! : symbol number person person  ->  person
;; to construct a person structure for a newborn 
;; effect: to add the new structure to the children of father and mother
(define (add-child! name soc-sec father mother)
  (local ((define the-child
	    (make-person name soc-sec father mother empty)))
    (begin
      (set-person-children! father
	                    (cons the-child (person-children father)))
      (set-person-children! mother
	                    (cons the-child (person-children mother)))
      the-child)))
