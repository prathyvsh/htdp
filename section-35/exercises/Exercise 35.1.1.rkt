#|
(set! x 5) ;legal
(define x 3) ;legal
(set! (+ x 1) 5) ;illegal since set! is being applied to an expression instead
                 ; of a variable.
(define x 3) ;illegal since x has already been defined
(define y 7) ;illegal
(define z false) ;illegal
(set! (z x y) 5) ;illegal since set! is being applied to an expression.
|#
