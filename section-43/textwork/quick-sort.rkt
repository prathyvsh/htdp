;; qsort : (vectorof number)  ->  (vectorof number)
;; effect: to modify V such that it contains the same items as before,
;; in ascending order  
(define (qsort V)
  (qsort-aux V 0 (sub1 (vector-length V))))

;; qsort-aux : (vectorof number) N N  ->  (vectorof number)
;; effect: sort the interval [left,right] of vector V
;; generative recursion
(define (qsort-aux V left right)
  (cond
    [(>= left right) V]
    [else (local ((define new-pivot-position (partition V left right)))
            (begin (qsort-aux V left (sub1 new-pivot-position))
                   (qsort-aux V (add1 new-pivot-position) right)))]))
;; partition : (vectorof number) N N  ->  N
;; to determine the proper position p of the pivot-item 
;; effect: rearrange the vector V so that 
;; -- all items in V in [left,p) are smaller than the pivot item
;; -- all items of V in (p,right] are larger than the pivot item
;; generative recursion
(define (partition V left right)
  (local ((define pivot-position left)
          (define the-pivot (vector-ref V left))
          (define (partition-aux left right)
            (local ((define new-right (find-new-right V the-pivot left right))
                    (define new-left (find-new-left V the-pivot left right)))
              (cond
                [(>= new-left new-right)
                 (begin
                   (swap V pivot-position new-right)
                   new-right)]
                [else ; (< new-left new-right)
                 (begin
                   (swap V new-left new-right)
                   (partition-aux new-left new-right))]))))
    (partition-aux left right)))

;; find-new-right : (vectorof number) number N N [>= left]  ->  N
;; to determine an index i between left and right (inclusive)
;; such that (< (vector-ref V i) the-pivot) holds
;; structural recursion: see text
(define (find-new-right V the-pivot left right)
  (cond
    [(= right left) right]
    [else (cond
	    [(< (vector-ref V right) the-pivot) right]
	    [else (find-new-right V the-pivot left (sub1 right))])]))
