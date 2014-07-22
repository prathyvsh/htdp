;; contains? : symbol los  ->  boolean
;; to determine whether alos contains the symbol s
(define (contains? s alos)
  (cond
    [(empty? alos) false]
    [else (cond
	    [(symbol=? (first alos) s)
             true]
	    [else 
	     (contains? s (rest alos))])]))
