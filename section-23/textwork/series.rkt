;; make-even : N  ->  N[even]
;; to compute the i-th even number
(define (make-even i)
  (* 2 i))
            	
;; make-odd : N  ->  N[odd]
;; to compute the i-th odd number
(define (make-odd i)
  (+ (* 2 i) 1))

;; series-even1 : N  ->  number
(define (series-even1 n)
  (series n make-even))	
     	
;; series-odd1 : N  ->  number
(define (series-odd1 n)
  (series n make-odd))

;; series : N (N  ->  number)  ->  number
;; to sum up the first n numbers in the sequence a-term,
(define (series n a-term)
  (cond
    [(= n 0) (a-term n)]
    [else (+ (a-term n)
	     (series (- n 1) a-term))]))
