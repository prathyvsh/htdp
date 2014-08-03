#lang racket
(require lang/htdp-intermediate)

;; line equation
(define (y x) (+ (- (* x x) (* 4 x)) 7))

;; d/dx : (number  ->  number)  ->  (number  ->  number)
;; to compute the derivative function of f numerically
(define (d/dx f)
  (local ((define (fprime x)
           (/ (- (f (+ x e)) (f (- x e)))
              (* 2 e)))
    (define e 1))
    fprime))

(define slope-at (d/dx y))

(equal? (slope-at 2) 0)
(equal? (slope-at 4) 4)
