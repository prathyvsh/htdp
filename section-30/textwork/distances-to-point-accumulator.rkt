;; relative-2-absolute2 : (listof number)  ->  (listof number)
;; to convert a list of relative distances to a list of absolute distances
;; the first item on the list represents the distance to the origin
(define (relative-2-absolute2 alon)
  (local ((define (rel-2-abs alon accu-dist)
	    (cond
	      [(empty? alon) empty]
	      [else (cons (+ (first alon) accu-dist)
		          (rel-2-abs (rest alon) (+ (first alon) accu-dist)))])))
    (rel-2-abs alon 0)))
