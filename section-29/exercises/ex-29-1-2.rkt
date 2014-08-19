;; maxi2 : ne-list-of-numbers  ->  number
;; to determine the maximum of a list of numbers 
(define (maxi2 alon)
  (cond
   [(empty? (rest alon)) (first alon)]
   [else (local ((define max-of-rest (maxi2 (rest alon))))
           (cond
            [(> max-of-rest (first alon)) max-of-rest]
            [else (first alon)])])))


#|

;; HAND EVALUATIONS

(maxi2 (list 0 1 2 3))

(cond
 [(empty? (list 1 2 3)) (first (list 0 1 2 3))]
 [else (local ((define max-of-rest (maxi2 (rest (list 0 1 2 3)))))
         (cond
          [(> max-of-rest (first (list 0 1 2 3))) max-of-rest]
          [else (first (list 0 1 2 3))])])))

(define max-of-rest-1 (maxi2 (rest (list 0 1 2 3))))
(cond
 [(> max-of-rest-1 (first (list 0 1 2 3))) max-of-rest-1]
 [else (first (list 0 1 2 3))])])))

(maxi2 (list 1 2 3))

(maxi2 (list 2 3))

(maxi2 (list 3))

#|

;; maxi2 requires one natural recursion for each application.
;; Hence the abstract running time of maxi2 is of the order of N.


