;; hellos : N  ->  list-of-symbols
;; to create a list of n copies of 'hello
(define (hellos n)
  (cond
    [(zero? n) empty]
    [else (cons 'hello (hellos (sub1 n)))]))
