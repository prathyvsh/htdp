#lang racket
(require lang/htdp-intermediate-lambda)

(define TOLERANCE 0.01)

;; newton : (number  ->  number) number  ->  number
;; to find a number r such that (< (abs (f r)) TOLERANCE)
(define (newton f r0)
  (cond
    [(<= (abs (f r0)) TOLERANCE) r0]
    [else (newton f (find-root-tangent f r0))]))

;; find-root-tangent : (number  ->  number) number  ->  number
;; to find the root of the tagent of f at r0
(define (find-root-tangent f r0)
  (local ((define fprime (d/dx f)))
    (- r0
       (/ (f r0)
	  (fprime r0)))))

;; d/dx : (number  ->  number)  ->  (number  ->  number)
;; to compute the derivative function of f numerically
(define (d/dx f)
  (local ((define (fprime x)
           (/ (- (f (+ x e)) (f (- x e)))
              (* 2 e)))
    (define e 1))
    fprime))
