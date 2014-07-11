;; value : list-of-numbers list-of-numbers -> number
;; Consumes two lists, one that stands for coefficients of a linear
;; equation and the other one the solutions. It then solves the former
;; using the latter.
;; ASSUMPTION: Both lists are of equal length
(define (value loc los)
  (cond
    [(empty? loc) 0]
    [else (+ (* (first loc) (first los)) (value (rest loc) (rest los)))]))

;; TESTS
(check-expect (value '(1 2 3) '(1 2 3)) 14)
(check-expect (value '(8) '(9)) 72)
