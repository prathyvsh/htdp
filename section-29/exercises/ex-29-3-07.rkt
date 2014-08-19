#lang racket
(require lang/htdp-intermediate-lambda)

;; norm : vector -> number
(define (norm vec)
  (sqrt (vector-sum (sqr-vec vec))))

;; sqr-vec : vector -> vector
;; Sums the numbers in the given vector
(define (sqr-vec vec)
  (build-vector (vector-length vec) (lambda (x) (sqr (vector-ref vec x)))))

;; vector-sum : (vectorof number)  ->  number
;; to compute the sum of the numbers in v
(define (vector-sum v) 
  (vector-sum-aux v (vector-length v)))
;; vector-sum-aux : (vectorof number) N  ->  number
;; to sum the numbers in v with index in [0, i)
(define (vector-sum-aux v i) 
  (cond
   [(zero? i) 0]
   [else (+ (vector-ref v (sub1 i)) 
            (vector-sum-aux v (sub1 i)))])) 


;; TESTS
(equal? (sqr-vec (vector 4 5)) (vector 16 25))
(equal? (norm (vector 3 4)) 5)
(equal? (norm (vector 1 1 1 1 1 1 1 1 1)) 3)
