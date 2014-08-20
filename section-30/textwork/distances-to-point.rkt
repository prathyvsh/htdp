;; relative-2-absolute : (listof number)  ->  (listof number)
;; to convert a list of relative distances to a list of absolute distances
;; the first item on the list represents the distance to the origin
(define (relative-2-absolute alon)
  (cond
    [(empty? alon) empty]
    [else (cons (first alon)
	        (add-to-each (first alon) (relative-2-absolute (rest alon))))]))

;; add-to-each : number (listof number)  ->  (listof number)
;; to add n to each number on alon
(define (add-to-each n alon)
  (cond
    [(empty? alon) empty]
    [else (cons (+ (first alon) n) (add-to-each n (rest alon)))]))
