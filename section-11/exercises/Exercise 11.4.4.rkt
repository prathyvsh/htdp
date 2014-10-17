#lang racket
(require lang/htdp-beginner)

;; product-from-20: N [>= 20]  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  21  ·  1
(define (product-from-20 n-above-20)
  (cond
    [(= n-above-20 20) 1]
    [else (* n-above-20 (product-from-20 (sub1 n-above-20)))]))


;; tabulate-f20 : N -> list-of-posns
;; Creates a table by applying product-from-20 for numbers 21 to n
(define (tabulate-f20 n)
  (cond
    [(= 20 n) empty]
    [else (cons (make-posn n (product-from-20 n)) (tabulate-f20 (sub1 n)))]))

;; TESTS
(tabulate-f20 21) "should be" (cons (make-posn 21 21) empty)
(tabulate-f20 22) "should be" (cons (make-posn 22 462) (cons (make-posn 21 21) empty))
