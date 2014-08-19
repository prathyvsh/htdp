#lang racket
(require lang/htdp-intermediate-lambda)

#|
;; HAND EVALUATIONS

(lr-vector-sum (vector -1 3/4 1/4))

(+ (vector-ref (vector -1 3/4 1/4) 0)
   (vector-sum-aux (vector -1 3/4 1/4) 1))

(+ -1 (vector-sum-aux (vector -1 3/4 1/4) 1))

(+ -1 3/4 (vector-sum-aux (vector -1 3/4 1/4) 2))

(+ -1 3/4 1/4 (vector-sum-aux (vector -1 3/4 1/4)) 3)

(+ -1 3/4 1/4 0)

0

;; The numbers get added in the order they are defined.
|#

;; lr-vector-sum : (vectorof number)  ->  number
;; to sum up the numbers in v
(define (lr-vector-sum v)
  (local ((define length (vector-length v))
    ;; vector-sum : (vectorof number)  ->  number
    ;; to sum up the numbers in v with index in [i, (vector-length v))
    (define (vector-sum-aux i)
      (cond
       [(= i length) 0]
       [else (+ (vector-ref v i) (vector-sum-aux (add1 i)))])))
(vector-sum-aux 0)))

;; TESTS
(equal? (lr-vector-sum (vector 1/4 3/4 -1)) 0)

