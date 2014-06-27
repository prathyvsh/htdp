;; add: N N  ->  N
;; Adds n with x
(define (add n x)
  (cond
    [(zero? x) n]
    [else (add1 (add n (sub1 x)))]))

;; multiply : N N -> N
;; Multiply n by x
(define (multiply n x)
  (cond
    [(zero? x) 0]
    [else (add n (multiply n (sub1 x)))]))

;; exponent: N N -> N
;; Raises n to the power of x
(define (exponent n x)
  (cond
    [(zero? x) 1]
    [else (multiply n (exponent n (sub1 x)))]))

;; TESTS
(= (exponent 2 3) 8)
(= (exponent 2 8) 256)
(= (exponent 9 3) 729)
