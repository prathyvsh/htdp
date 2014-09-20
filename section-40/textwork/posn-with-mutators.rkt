(define (fm-make-posn x0 y0)
  (local ((define x y0)
	  (define y y0)
	  (define (service-manager msg)
	    (cond
	      [(symbol=? msg 'x) x]
	      [(symbol=? msg 'y) y]
	      [(symbol=? msg 'set-x) (lambda (x-new) (set! x x-new))]
	      [(symbol=? msg 'set-y) (lambda (y-new) (set! y y-new))]
	      [else (error 'posn "...")])))
    service-manager))

(define (fm-posn-x p)
  (p 'x))

(define (fm-posn-y p)
  (p 'y))

(define (fm-set-posn-x! p new-value)
  ((p 'set-x) new-value))

(define (fm-set-posn-y! p new-value)
  ((p 'set-y) new-value))
