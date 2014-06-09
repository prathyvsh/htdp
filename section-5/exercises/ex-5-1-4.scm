;; what-kind : number number number -> symbol
;; Determines the nature of the quadratic equation from the coefficients
;; given
(define (what-kind a b c)
  (cond
    [(= a 0) 'degenerate]
    [(> (sqr b) ( * 4 a c)) 'two]
    [(= (sqr b) ( * 4 a c)) 'one]
    [(< (sqr b) ( * 4 a c)) 'none]))

;; TESTS
(symbol=? (what-kind 1 0 -1)'two)
(symbol=? (what-kind 2 4 2) 'one)
(symbol=? (what-kind 2 1 2) 'none)
(symbol=? (what-kind 0 20 -1) 'degenerate)

