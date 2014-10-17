#lang racket
(require lang/htdp-beginner)

;; product-from-minus-11: N [>= -11]  ->  integer
;; to compute n  ·  (n - 1)  ·  ...  ·  21  ·  1
(define (product-from-minus-11 n-above-minus-11)
  (cond
    [(= n-above-minus-11 (- 11)) 1]
    [else (* n-above-minus-11 (product-from-minus-11 (sub1 n-above-minus-11)))]))

;; TESTS
(= (product-from-minus-11 -11) 1)
(= (product-from-minus-11 -10) -10)
(= (product-from-minus-11 0) 0)
