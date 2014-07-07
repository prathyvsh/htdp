;; cross : list-of-symbols list-of-numbers -> list-of-pairs
;; Creates cross product of list of symbols and numbers
(define (cross symbols numbers)
  (cond
    [(empty? symbols) empty]
  [else (append (multiply (first symbols) numbers) (cross (rest symbols) numbers))]))

;; multiply : symbol list-of-numbers -> list-of-pairs
(define (multiply symbol lon)
  (cond
    [(empty? lon) empty]
    [else (append (list (list symbol (first lon))) (multiply symbol (rest lon)))]))

;; TESTS
(check-expect (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
