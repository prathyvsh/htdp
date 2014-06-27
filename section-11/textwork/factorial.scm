;; TEMPLATE
;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (! n)
  (cond
    [(zero? n) ...]
    [else ... (! (sub1 n)) ... ]))

;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (! n)
  (cond
    [(zero? n) 1]
    [else (* n (! (sub1 n))) ]))

;; product-from-20: N [>= 20]  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  21  ·  1
(define (product-from-20 n-above-20)
  (cond
    [(= n-above-20 20) 1]
    [else (* n-above-20 (product-from-20 (sub1 n-above-20)))]))

;; product: N[limit] N[>= limit]  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  (limit + 1)  ·  1
(define (product limit n)
  (cond
    [(= n limit) 1]
    [else (* n (product limit (sub1 n)))]))
