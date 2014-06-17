#|
FORMAT: ( define ( non-empty sequence of variables ) an expression )
1. (define (f x) 'x)
matches the FORMAT.
2. (define (f 'x) x)
Doesn't match FORMAT since 'x is not a variable, it is a symbol.
3. (define (f x y) (+ 'y (not x)))
matches the FORMAT.
|#

