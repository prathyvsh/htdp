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

;; A function definition is
;; (make-func symbol symbol exp)
(define-struct func (name params body))

;; DEFINITONS
;;(define (f x) (+ 3 x))
(make-func 'f 'x (make-add 3 'x))

;;(define (g x) (* 3 x))
(make-func 'g 'x (make-mul 3 'x))

;;(define (h u) (f (* 2 u)))
(make-func 'h 'u (make-app 'f (make-mul 2 'u)))

;;(define (i v) (+ (* v v) (* v v)))
(make-func 'i 'v (make-add
                   (make-mul 'v 'v)
                   (make-mul 'v 'v)))

;;(define (k w) (* (h w) (i w)));
(make-func 'k 'w (make-mul (make-app 'h 'w) (make-app 'i 'w)))

;;(define (t u) (i (* (+ 3 u) u) u))
(make-func 'i 'u (make-app 'i (make-mul (make-add 3 'u) 'u)))
