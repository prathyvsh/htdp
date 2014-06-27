;; product: N[limit] N[>= limit]  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  (limit + 1)  ·  1
(define (product limit n)
  (cond
    [(= n limit) 1]
    [else (* n (product limit (sub1 n)))]))


;; tabulate-f-lim : N -> list-of-posns
;; Creates a table by applying product for numbers limit + 1 to n
(define (tabulate-f-lim limit n)
  (cond
    [(= n limit) empty]
    [else (cons (make-posn n (product limit n)) (tabulate-f-lim limit (sub1 n)))]))

;; TESTS
(tabulate-f-lim 20 21) "should be" (cons (make-posn 21 21) empty)
(tabulate-f-lim 20 22) "should be" (cons (make-posn 22 462) (cons (make-posn 21 21) empty))
(tabulate-f-lim 0 0) "should be" empty
(tabulate-f-lim 100 100) "should be" empty
(tabulate-f-lim 500 501) "should be" (cons (make-posn 501 501) empty)
(tabulate-f-lim 1 5) "should be" (cons (make-posn 5 120) (cons (make-posn 4 24) (cons (make-posn 3 6) (cons (make-posn 2 2) (cons (make-posn 1 1) empty)))))
