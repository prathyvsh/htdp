#lang racket
(require lang/htdp-intermediate-lambda)

;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
;; structural recursion 
(define (! n)
  (cond
    [(zero? n) 1]
    [else (* n (! (sub1 n)))]))

;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (!-acc n0)
  (local (;; accumulator is the product of all natural numbers in [n0, n)
	  (define (!-a n accumulator)
	    (cond
	      [(zero? n) accumulator]
	      [else (!-a (sub1 n) (* n accumulator))])))
    (!-a n0 1)))

;; many : N (N  ->  N)  ->  true
;; to evaluate (f 20) n times 
(define (many n f)
  (cond [(zero? n) true]
        [else (and (= (f 20) 2432902008176640000) (many (sub1 n) f))]))


(collect-garbage)
(time (many 1000000 !-acc))

(collect-garbage)
(time (many 1000000 !))
