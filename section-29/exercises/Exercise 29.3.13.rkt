#lang racket
(require lang/htdp-intermediate-lambda)

;; distance : vector vector -> number
(define (distance v1 v2)
  (sqrt (vector-sum (difference-of-sqr v1 v2))))

;; difference-of-sqr : vector vector -> vector
;; Creates a vector with the difference of squares of difference of
;; corresponding elements
(define (difference-of-sqr v1 v2)
  (build-vector (vector-length v1)
                (lambda (i) (sqr (- (vector-ref v2 i) (vector-ref v1 i))))))

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


;; TESTS
(equal? (difference-of-sqr (vector 1 1) (vector 1 1)) (vector 0 0))
(equal? (difference-of-sqr (vector 4 4) (vector 1 1)) (vector 9 9))
(equal? (distance (vector 1 1 1) (vector 0 0 0)) (sqrt 3))
(equal? (distance (vector 2 3 3) (vector 1 1 1)) 3)
