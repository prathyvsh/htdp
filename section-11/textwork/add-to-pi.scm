;; add-to-pi : N  ->  number
;; to compute n + 3.14 without using +
(define (add-to-pi n)
  (cond
    [(zero? n) 3.14]
    [else (add1 (add-to-pi (sub1 n)))]))
