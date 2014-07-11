;; merge : list-of-numbers list-of-numbers -> list-of-numbers
;; Merges two list of numbers.
(define (merge lon1 lon2)
  (cond
    [(empty? lon1) lon2]
    [(empty? lon2) lon1]
    [else (cond
            [(<= (first lon1) (first lon2)) (cons (first lon1) (merge (rest lon1) lon2))]
            [else (cons (first lon2) (merge lon1 (rest lon2)))])]))
        

;; TESTS
(check-expect (merge '(1 2 3) empty) '(1 2 3))
(check-expect (merge empty '(1 2 3)) '(1 2 3))
(check-expect (merge empty empty) empty)
(check-expect (merge '(1 2 3) '(4 5)) '(1 2 3 4 5))
(check-expect (merge '(1 3 5 7 9) '(0 2 4 6 8)) '(0 1 2 3 4 5 6 7 8 9))
(check-expect (merge '(1 8 8 11 12) '(2 3 4 8 13 14)) '(1 2 3 4 8 8 8 11 12 13 14))
