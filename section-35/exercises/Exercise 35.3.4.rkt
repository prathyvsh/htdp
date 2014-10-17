(define x 0)
(define y 1)

(define (change-to-3 z)
(begin (set! y 3) z))

(change-to-3 x)


;; The effect of change-to-3 is
;; to set the value of y to 3.
;; The result is the input value.
