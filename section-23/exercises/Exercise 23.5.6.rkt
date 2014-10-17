#lang racket
(require lang/htdp-intermediate)

;; function to find slope of
(define (f x) 
  (+ (* 1/60 (* x x x))
     (* -1/10 (* x x))
     5))

;; d/dx : (number  ->  number)  ->  (number  ->  number)
;; to compute the derivative function of f numerically
(define (d/dx f e)
  (local ((define (fprime x)
            (/ (- (f (+ x e)) (f (- x e)))
               (* 2 e))))
    fprime))

(define slope-at-2 (d/dx f 2))
(define slope-at-1 (d/dx f 1))
(define slope-at-0.5 (d/dx f 0.5))

(slope-at-2 4)
(slope-at-1 4)
(slope-at-0.5 4)

(slope-at-2 2)
(slope-at-1 2)
(slope-at-0.5 2)
