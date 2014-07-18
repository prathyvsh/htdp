1. (local ((define x (* y 3)))
     (* x x))

;; Local Definitions

Variables: x

;; Right Hand Sides
(* y 3)

;; Body of the Local Expression
(* x x)

2. (local ((define (odd an) (cond
                [(zero? an) false]
[else (even (sub1 an))])) (define (even an)
(cond
[(zero? an) true]
[else (odd (sub1 an))])))
(even a-nat-num))
;; Local Definitions
Functions: odd, even
;; Right Hand Sides
(cond
 [(zero? an) false]
 [else (even (sub1 an))])
(cond
 [(zero? an) true]
 [else (odd (sub1 an))])
;; Body of the Local Expression
(even a-nat-num)

3. (local ((define (f x) (g x (+ x 1)))
(define (g x y) (f (+ x y)))) (+ (f 10) (g 10 20)))

;; Local Definitions
Functions: f g
;; Right Hand Sides
(g x (+ x 1))
(f (+ x y))
;; Body
(+ (f 10) (g 10 20))
