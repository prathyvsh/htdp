;; gcd-generative : N[>= 1] N[>=1]  ->  N
;; to find the greatest common divisior of n and m
;; generative recursion: (gcd n m) = (gcd n (remainder m n)) if (<= m n)
(define (gcd-generative n m)
  (local ((define (clever-gcd larger smaller)
	    (cond
	      [(= smaller 0) larger]
	      [else (clever-gcd smaller (remainder larger smaller))])))
    (clever-gcd (max m n) (min m n))))
