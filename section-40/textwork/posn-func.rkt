(define-struct posn (x y))

(define (f-make-posn x0 y0)
  (local ((define x x0)
	  (define y y0)
	  (define (service-manager msg)
	    (cond
	      [(symbol=? msg 'x) x]
	      [(symbol=? msg 'y) y]
	      [else (error 'posn "...")])))
    service-manager))

(define (f-posn-x p)
  (p 'x))

(define (f-posn-y p)
  (p 'y))
