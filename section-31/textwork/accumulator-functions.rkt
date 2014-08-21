;; sum : (listof number)  ->  number
;; to compute the sum of the numbers on alon0
(define (sum alon0)
  (local (;; accumulator is the sum of the numbers that preceded
	  ;; those in alon on alon0
	  (define (sum-a alon accumulator)
	    (cond
	      [(empty? alon) accumulator]
	      [else (sum-a (rest alon) (+ (first alon) accumulator))])))
    (sum-a alon0 0)))
;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (! n0)
  (local (;; accumulator is the product of all natural numbers in [n0, n)
	  (define (!-a n accumulator)
	    (cond
	      [(zero? n) accumulator]
              [else (!-a (sub1 n) (* n accumulator))])))
                             (!-a n0 1)))

;; height : tree  ->  number
;; to measure the height of abt0
(define (height abt0)
  (local (;; accumulator represents how many nodes height-a 
          ;; has encountered on its way to abt from abt0
          (define (height-a abt accumulator)
            (cond
              [(empty? abt) accumulator]
              [else (max (height-a (node-left abt)  (+ accumulator 1))
                         (height-a (node-right abt) (+ accumulator 1)))])))
    (height-a abt0 0)))
