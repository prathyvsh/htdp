#lang racket
(require lang/htdp-intermediate-lambda)

;; find-root : (number  ->  number) number number  ->  number
;; to determine a number R such that f has a 
;; root between R and (+ R TOLERANCE) 
;; ASSUMPTION: f is continuous and monotonic
(define (find-root f left right)
  (cond
   [(<= (- right left) TOLERANCE) left]
   [else 
    (local ((define mid (/ (+ left right) 2)))
      (cond
       [(<= (f mid) 0 (f right)) 
        (find-root f mid right)]
       [else 
        (find-root f left mid)]))]))

;; poly : number  ->  number
(define (poly x)
 (* (- x 2) (- x 4)))

;; TESTS
(define TOLERANCE 0.0001)
(< 0 (- 4 (find-root poly 3 6)) 1/10000)
