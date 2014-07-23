;; Values among the expressions are:
(cons f empty)
;; f is a <var>
;; empty is <lst>
;; Hence the expression is a valid <lst>

(f f)
;; (f f) is not a <val> since it is a function application

(cons f (cons 10 (cons (f 10) empty)))

;; f is a <var>
;; (f 10) is a function application
;; Hence this expression is not a val, it remains as an expression
