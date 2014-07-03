;; A scheme expression is either
;; empty
;; number or symbol
;; (make-struct exp1 exp2)
;; where exp1 and exp2 are scheme expressions.

(define-struct add (lhs rhs))
(define-struct mul (lhs rhs))

(make-add 10 -10)
(make-mul (make-add 20 3) 33)
(make-mul 3.14 (make-mul r r))
(make-add (make-mul 9/5 c) 32)
(make-add (make-mul 3.14 (make-mul 0 0)) (make-mul 3.14 (make-mul i i)))
