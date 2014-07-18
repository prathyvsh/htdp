1. (local ((define x 10) (y (+ x x)))
y)
;; This function is not syntactically legal because the function y is not defined and it is being applied without any variables.
2. (local ((define (f x) (+ (* x x) (* 3 x) 15))
(define x 100)
(define f@100 (f x))) f@100 x)
;; This function is not syntactically legal because
;; the function f@100 is not being applied to a variable.

3. (local ((define (f x) (+ (* x x) (* 3 x) 14)) (define x 100)
(define f (f x))) f)
;; This function is not syntactically legal because the function f is not
;; being applied to any variable.
