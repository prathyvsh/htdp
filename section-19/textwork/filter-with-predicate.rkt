;; Function header missing as definition has
;; not yet been taught in the course
;; Filters out elements from alon that meets the predicate's
;; condition.
(define (filter predicate alon)
  (cond
    [(empty? alon) empty]
    [else (cond
	    [(predicate (first alon)) 
	     (cons (first alon)
	       (filter predicate (rest alon)))]
	    [else
	     (filter predicate (rest alon))])]))
