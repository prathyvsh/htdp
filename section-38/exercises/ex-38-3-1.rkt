#|
1. (define x 11)
     (begin (set! x (* x x)) x)
;; Next expression to be evaluated is (* 11 11)
;; since it is required to find the new value
;; of x

2. (define x 11)
     (begin (set! x 
	 (cond [(zero? 0) 22]
	   [else (/ 1 x)]))
       'done)
;; (zero? 0) is to be evaluated in order
;; to get the value of the cond expression
;; which would be used to determine the
;; new value of x

3. (define (run x) (run x)) (run 10)
;; First expression to be evaluated
;; would be (run 10)

4. (define (f x) (* pi x x))
   (define a1 (f 10))
   (begin (set! a1 (- a1 (f 5))) 'done)
;; First expression to be evaluated
;; would be (* pi 10 10)

5. (define (f x) (set! state (- 1 state)))
   (define state 1)
   (f (f (f)))
;; First expression to be evaluated
;; would be  (f) but it would throw
;; an exception since the arity is
;; not matched.
|#
