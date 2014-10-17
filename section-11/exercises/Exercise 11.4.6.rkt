#lang racket
(require lang/htdp-beginner)

;; tabulate-f-up-to-20 : N [<= 20]  ->  N
;; Computes n * (n + 1) * ... * 20
(define (tabulate-f-up-to-20 n-below-20)
  (cond
    [(= n-below-20 20) empty]
    [else (cons (make-posn n-below-20 (product-up-to-20 n-below-20)) (tabulate-f-up-to-20 (add1 n-below-20)))]))


;; product-from-20: N [<= 20]  ->  N
;; to compute n  
(define (product-up-to-20 n-below-20)
  (cond
    [(= n-below-20 20) 20]
    [else (* n-below-20 (product-up-to-20 (add1 n-below-20)))]))

;; TESTS
(tabulate-f-up-to-20 20) "should be" empty
(tabulate-f-up-to-20 17) "should be"
(cons (make-posn 17 (* 17 18 19 20))
(cons (make-posn 18 (* 18 19 20))
(cons (make-posn 19 (* 19 20)) empty)))
