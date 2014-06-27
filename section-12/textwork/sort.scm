;; WISH LIST
;; sort : list-of-numbers -> list-of-numbers
;; to create a sorted list of numbers from all the numbers in alon
(define (sort alon) ...)
;; EXAMPLE
;; (sort empty)
;; expected value : empty
;; (sort (cons 1297.04 (cons 20000.00 (cons -505.25 empty))))
;; expected value : (cons 20000.00 (cons 1297.04 (cons -505.25 empty)))

;; insert : number list-of-numbers -> list-of-numbers
;; to create a list of numbers from n and the numbers on alon
;; that is sorted in descending order; alon is already sorted
(define (insert n alon) ...)

;; EXAMPLE
;; (insert 5 empty)
;; expected : (cons 5 empty)
;; (insert 1297.04 (cons 20000.00 (cons -505.25 empty)))
;; expected : (cons 20000.00 (cons 1297.04 (cons -505.25 empty)))

;; DEFINITIONS
;; sort : list-of-numbers -> list-of-numbers
;; to create a sorted list of numbers from all the numbers in alon
(define (sort alon)
  (cond
    [(empty? alon) empty]
    [else (insert (first alon) (sort (rest alon)))]))

;; insert : number list-of-numbers -> list-of-numbers
;; to create a list of numbers from n and the numbers on alon
;; that is sorted in descending order; alon is already sorted
(define (insert n aslon)
  (cond
    [(empty? aslon) (cons n empty)]
    [else (cond
            [(>= n (first alon)) (cons n aslon)]
            [(< n (first alon)) (cons (first aslon)
                                      (insert n (rest aslon)))])]))
