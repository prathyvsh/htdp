#lang racket
(require lang/htdp-beginner)

;; A numeric expression is either
;; empty
;; number
;; (make-struct exp1 exp2)
;; where exp1 and exp2 are numeric expressions.

(define-struct add (lhs rhs))
(define-struct mul (lhs rhs))

(define (evaluate-expression exp)
  (cond
    [(empty? exp) empty]
    [(number? exp) exp]
    [(symbol? exp) (error 'evaluate-expression "Cannot evaluate a variable")]
    [(add? exp) (+ (evaluate-expression (add-lhs exp)) (evaluate-expression (add-rhs  exp)))]
    [(mul? exp) (* (evaluate-expression (mul-lhs exp)) (evaluate-expression (mul-rhs exp)))]
    [else (error 'evaluate-expression "Unknown expression type")]))

;; TESTS
(evaluate-expression (make-add 10 -10))
(evaluate-expression (make-mul (make-add 20 3) 33))
(evaluate-expression (make-mul 3.14 (make-mul 3 3)))
(evaluate-expression (make-add (make-mul 9/5 10) 32))
(evaluate-expression (make-add (make-mul 3.14 (make-mul 0 0)) (make-mul 3.14 (make-mul 2 2))))
(evaluate-expression 'hello)
