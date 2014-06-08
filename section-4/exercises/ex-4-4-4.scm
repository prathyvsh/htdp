;; how-many number number number -> number
;; Takes in coefficients of a proper quadratic equation and returns the number of solutions for the equation
;; If we didn't assume the quadratic function that gets passed in as
;; proper we would have to make up a case where a = 0 and return a
;; proper value like "many" or "degenarate". I think the numerical
;; equivalent to this would be infinity but not sure how to represent
;; it with the current signature of returning a number. The text
;; does not mention a mechanism for dealing with infinities yet.
(define (how-many a b c)
  (cond
    [(> (sqr b) ( * 4 a c)) 2]
    [(= (sqr b) ( * 4 a c)) 1]
    [(< (sqr b) ( * 4 a c)) 0]))

;; TESTS
(= (how-many 1 0 -1) 2)
(= (how-many 2 4 2) 1)
(= (how-many 2 1 2) 0)
