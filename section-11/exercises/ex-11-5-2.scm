;; multiply-by-pi : N  ->  number
;; to compute n + 3.14 without using +
(define (multiply-by-pi n)
  (cond
    [(zero? n) 0]
    [else (+ 3.14 (multiply-by-pi (sub1 n)))]))

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

;; TESTS
(= (multiply-by-pi 0) 0)
(= (multiply-by-pi 2) 6.28)
(= (multiply-by-pi 3) 9.42)

(= (multiply 3 4) 12)
(= (multiply 4 4) 16)
(= (multiply 5 2) 10)
