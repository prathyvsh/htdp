#lang racket
(require lang/htdp-beginner)

;; A scheme expression is either
;; empty
;; number or symbol
;; (make-struct exp1 exp2)
;; where exp1 and exp2 are scheme expressions.

(define-struct add (lhs rhs))
(define-struct mul (lhs rhs))

;; subst : symbol number scheme-expression -> scheme-expression
;; Produces a scheme expression with v substituted with n
(define (subst v n exp)
  (cond
    [(empty? exp) empty]
    [(number? exp) exp]
    [(symbol? exp)
     (cond
          [(symbol=? exp v) n]
          [else exp])]
    [(add? exp) (make-add (subst v n (add-lhs exp)) (subst v n (add-rhs exp)))]
    [(mul? exp) (make-mul (subst v n (mul-lhs exp)) (subst v n (mul-rhs exp)))]
    [else (error 'subst "Malformed expression")]))

;; TESTS
(subst 'ten 10 (make-add 'ten -10))
(subst 'r 3 (subst 'pi 3.14 (make-mul 'pi (make-mul 'r 'r))))
(subst 'degree 32 (make-add (make-mul 9/5 10) 'degree))
(subst 'pi 3.14 (make-add (make-mul 'pi (make-mul 0 0)) (make-mul 'pi (make-mul 2 2))))
