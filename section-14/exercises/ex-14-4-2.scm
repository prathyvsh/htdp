;; A scheme expression is either
;; empty
;; number or symbol
;; (make-struct exp1 exp2)
;; where exp1 and exp2 are scheme expressions.

(define-struct add (lhs rhs))
(define-struct mul (lhs rhs))

;; numeric? scheme-expression -> boolean
;; Determines if the given exp is a numeric expression
(define (numeric? exp)
  (cond
    [(empty? exp) true]
    [(number? exp) true]
    [(symbol? exp) false]
    [(add? exp) (and (numeric? (add-lhs exp)) (numeric? (add-rhs exp)))]
    [(mul? exp) (and (numeric? (mul-lhs exp)) (numeric? (mul-rhs exp)))]
    [else false]))

;; TESTS
(numeric? (make-add 10 -10))
(numeric? (make-mul (make-add 20 3) 33))
(numeric? (make-mul 3.14 (make-mul 3 3)))
(numeric? (make-add (make-mul 9/5 10) 32))
(numeric? (make-add (make-mul 3.14 (make-mul 0 0)) (make-mul 3.14 (make-mul 2 2))))
(boolean=? (numeric? (make-mul 'hello 'there)) false)

