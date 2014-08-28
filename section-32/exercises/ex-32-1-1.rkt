;; A Lam is
;; (make-Lam (symbol exp))
(define-struct Lam (var exp))

;; An fn-apply is
;; (make-apply (exp1 exp2))

;; An exp is either
;; symbol
;; (make-Lam symbol exp)
;; or (make-apply exp exp)

#|
(lambda (x) y)
;; x is a bound variable
;; y is a free variable

((lambda (x) x)
 (lambda (x) x))

First x is a binding occurence of x in first lambda.
Second x is a binding occurence of the x in second one.


(((lambda (y)
    (lambda (x)
      y))
  (lambda (z) z))
 (lambda (w) w))

The y contained inside lambda(x) is bound to y of first lambda.
The z and w inside lambdas are bound to their respective z and w.
|#

(make-Lam ('x 'y))
(make-apply (make-Lam 'x 'x) (make-Lam 'x 'x))
(make-apply (make-apply (make-Lam 'y (make-Lam ('x 'y)))
                        (make-Lam 'z 'z))
            (make-Lam 'w 'w))

;; free x expression
(make-Lam 'y 'x)

;; bound x expression
(make-Lam 'x 'x)


