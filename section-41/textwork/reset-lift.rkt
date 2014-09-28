;; call-status : (vectorof boolean)
;; to keep track of the floors from which calls have been issued 
(define call-status (vector true true true false true true true false))

;; reset :  ->  void
;; effect: to set all fields in call-status to false
(define (reset)
  (reset-aux call-status (vector-length call-status)))

;; reset-aux : (vectorof boolean) N  ->  void
;; effect: to set the fields of v with index in [0, i) to false
(define (reset-aux v i)
  (cond
    [(zero? i) (void)]
    [else (begin
	    (vector-set! v (sub1 i) false)
	    (reset-aux v (sub1 i)))]))
