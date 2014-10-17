(define (f x) (x 10))
;; is a legal definition of the form
;; (define (<var> <var>) <exp>)
;; The <exp> has a valid syntax:
;; (<var> <num>)

(define (f x) f)
;; is a legal definition of the form
;; (define (<var> <var>) <exp>)
;; The <exp> has a valid syntax:
;; <var>

(define (f x y) (x 'a y 'b))
;; is a legal definition of the form
;; (define (<var> <var> <var>) <exp>)
;; The <exp> has a valid syntax:
;; (<var> <sym> <var> <sym>)
