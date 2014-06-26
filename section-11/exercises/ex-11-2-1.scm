;; repeat : N -> list-of-symbols
;; Creates a list of n copies of given symbol
(define (repeat symbol n)
(cond
  [(zero? n) empty]
  [else (cons symbol (repeat symbol (sub1 n)))]))

;; TESTS
(repeat 'blank 3) "should be"
(cons 'blank (cons 'blank (cons 'blank empty)))
