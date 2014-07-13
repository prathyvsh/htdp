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

;; evaluate-with-defs : scheme-expression list-of-functions -> number
;; Evaluates an expression with the given function definition list
(define (evaluate-with-defs exp fn-list)
  (cond
    [(empty? exp) empty]
    [(number? exp) exp]
    [(symbol? exp) (error evaluate-with-defs "Cannot evaluate a variable")]
    [(add? exp) (+ (evaluate-with-defs (add-lhs exp) fn-list) (evaluate-with-defs (add-rhs exp) fn-list))]
    [(mul? exp) (* (evaluate-with-defs (mul-lhs exp) fn-list) (evaluate-with-defs (mul-rhs exp) fn-list))]
    [(app? exp) (evaluate-with-defs (subst (func-params (find (app-name exp) fn-list))
                                              (evaluate-with-defs (app-args exp) fn-list)
                                              (func-body (find (app-name exp) fn-list))) fn-list)]
    [else (error 'evaluate-with-defs "Unknown expression type")]))

;; find : fname list-of-functions -> function
;; Finds function with fname from fn-list
(define (find fname fn-list)
  (cond
    [(empty? fn-list) (error 'find "Function" fname "not defined")]
    [(symbol=? fname (func-name (first fn-list))) (first fn-list)]
    [else (find fname (rest fn-list))]))

;; TESTS
;; Functions
(define double (make-func 'double 'x (make-add 'x 'x)))
(define triple (make-func 'triple 'x (make-add 'x (make-app 'double 'x))))
(define square (make-func 'square 'x (make-mul 'x 'x)))

;; Checks for find
(check-expect (find 'double (list double triple)) double)
(check-expect (find 'double (list triple double)) double) ;; Ensuring that the order doesn't matter

;; Checks for evaluate-with-defs
(check-expect (evaluate-with-defs (make-app 'square (make-app 'triple 3)) (list double square triple)) 81)
(check-expect (evaluate-with-defs (make-app 'triple (make-app 'square 2)) (list square double triple)) 12)
