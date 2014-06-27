;; product number number -> number
;; Takes in two numbers n and m and produces the product of numbers
;; between them
(define (product n m)
  (/ (! m) (! n)))

;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (! n)
  (cond
    [(zero? n) 1]
    [else (* n (! (sub1 n))) ]))

;; TESTS
(product 3 5) "should be" (* 5 4)
