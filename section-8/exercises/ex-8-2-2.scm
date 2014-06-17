#|
( define ( non-empty sequence of variables ) an expression )

1. (define (f x) x)
Fits the format: ( define ( non-empty sequence of variables ) an expression )

2. (define (f x) y)
Fits the format: ( define ( non-empty sequence of variables ) an expression )
3. (define (f x y) 3)
Fits the format: ( define ( non-empty sequence of variables ) an expression )

1. (define (f 'x) x)
Doesn't fit the format: ( define ( non-empty sequence of variables ) an expression ) since 'x is a symbol not a variable
2. (define (f x y z) (x))
Doesn't fit the format: ( define ( non-empty sequence of variables ) an expression ) since (x) is not a valid expression.
3. (define (f) 10) 
Doesn't fit the format: ( define ( non-empty sequence of variables ) an expression ) since (f) is a malformed expression not a set of variables.
|#
