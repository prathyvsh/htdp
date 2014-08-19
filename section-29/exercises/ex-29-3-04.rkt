#|
;; HAND EVALUATIONS
(vector-sum-aux (vector -1 3/4 1/4) 3)

(+ (vector-ref (vector -1 3/4 1/4) (sub1 3))
   (vector-sum aux (vector -1 3/4 1/4) (sub1 3))))

(+ 1/4 (vector-sum aux (vector -1 3/4 1/4) 2))

(+ 1/4 3/4 (vector-sum aux (vector -1 3/4 1/4) 1))

(+ 1/4 3/4 -1 (vector-sum aux (vector -1 3/4 1/4) 0))

(+ 1/4 3/4 -1 0)

0

;; The functions add up the numbers in the reverse order
|#

#lang racket
(require lang/htdp-intermediate-lambda)

;; vector-sum : (vectorof number)  ->  number
;; to compute the sum of the numbers in v
(define (vector-sum v) 
  (local (
          ;; vector-sum-aux : (vectorof number) N  ->  number
          ;; to sum the numbers in v with index in [0, i)
          (define (vector-sum-aux i) 
            (cond
             [(zero? i) 0]
             [else (+ (vector-ref v (sub1 i)) 
                      (vector-sum-aux (sub1 i)))])))
  (vector-sum-aux (vector-length v))))
;; We can remove the vector definition from vector-sum-aux since v
;; is captured by the parent function.


;; TESTS
(vector-sum (vector -1 3/4 1/4))

