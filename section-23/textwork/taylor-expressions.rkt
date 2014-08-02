;; e-taylor : N  ->  number
(define (e-taylor i)
  (/ (expt x i) (! i)))

;; ! : N  ->  number
(define (! n)
  (cond
    [(= n 0) 1]
    [else (* n (! (sub1 n)))]))

(define (e-power x)
  (local ((define (e-taylor i)
	    (/ (expt x i) (! i)))
	  (define (! n)
	    (cond
	      [(= n 0) 1]
	      [else (* n (! (sub1 n)))])))
    (series 10 e-taylor)))
