#lang racket
(require lang/htdp-beginner-abbr)

;; A scheme expression is either
;; empty
;; number or symbol
;; (make-struct exp1 exp2)

;; where exp1 and exp2 are scheme expressions.
(define-struct add (lhs rhs))
(define-struct mul (lhs rhs))
(define-struct app (name args))

;; EXAMPLES
;;
;; (f (+ 1 1))
;; (make-app 'f (make-add 1 1))
;;
;; (* 3 (g 2))
;; (make-mul 3 (make-app 'g 2))


;; A function definition is
;; (make-func symbol symbol exp)
(define-struct func (name params body))

;; EXAMPLES
#|
;;(define (f x) (+ 3 x))
(make-func 'f 'x (make-add 3 'x))

;;(define (g x) (* 3 x))
(make-func 'g 'x (make-mul 3 'x))

;;(define (h u) (f (* 2 u)))
(make-func 'h 'u (make-app 'f (make-mul 2 'u)))

;;(define (i v) (+ (* v v) (* v v)))
(make-func 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v)))
|#

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
    [(app? exp) (make-app (app-name exp) (subst v n (app-args exp)))]
    [else (error 'subst "Malformed expression")]))

;; evaluate-with-one-def : scheme-expression list-of-functions -> number
;; Evaluates an expression with the given function definition
(define (evaluate-with-one-def exp fn)
  (cond
    [(empty? exp) empty]
    [(number? exp) exp]
    [(symbol? exp) (error 'evaluate-with-one-def "Cannot evaluate a variable")]
    [(add? exp) (+ (evaluate-with-one-def (add-lhs exp) fn) (evaluate-with-one-def (add-rhs exp) fn))]
    [(mul? exp) (* (evaluate-with-one-def (mul-lhs exp) fn) (evaluate-with-one-def (mul-rhs exp) fn))]
    [(app? exp) (cond
                [(symbol=? (func-name fn) (app-name exp))
                 (evaluate-with-one-def (subst
                                          (func-params fn)
                                          (evaluate-with-one-def (app-args exp) fn)
                                          (func-body fn)) fn)]
                [else (error 'evaluate-with-one-def "Unknown function provided.")])]
    [else (error 'evaluate-expression "Unknown expression type")]))

;; TESTS
;(check-expect (evaluate-with-one-def empty empty) empty)
;(check-expect (evaluate-with-one-def (make-add 3 3) empty) 6)
;(check-expect (evaluate-with-one-def (make-app 'f (make-add 3 3)) (make-func 'f 'x (make-mul 'x 'x))) 36)
;;(evaluate-with-one-def (make-app 'f (make-add 'f 3)) (make-func 'f 'x (make-add 'x 'x)))
(define 2timessquare (make-func 'i 'v (make-add (make-mul 'v 'v) (make-mul 'v 'v))))
(check-expect (evaluate-with-one-def (make-app 'i (make-add 3 (make-mul 3 3))) 2timessquare) 288)
(define return3 (make-func 'i 'something 3))
(check-expect (evaluate-with-one-def (make-add (make-app 'i 8) (make-app 'i 8)) return3) 6)
(check-expect (evaluate-with-one-def (make-app 'square (make-app 'square (make-app 'square 3))) (make-func 'square 'x (make-mul 'x 'x))) (* 81 81))
