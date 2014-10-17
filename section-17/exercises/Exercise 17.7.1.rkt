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

;; (f (+ 1 1))
;; (make-app 'f (make-add lhs rhs))
;;
;; (* 3 (g 2))
;; (make-mul 3 (make-app 'g 2))
