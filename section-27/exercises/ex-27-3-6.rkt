#lang racket
(require lang/htdp-intermediate-lambda)

;; area-of-rectangle : number number -> number
(define (area-of-trapezoid width left-height right-height)
  (abs (* width (/ (+ left-height right-height) 2))))

;; TESTS
(equal? (area-of-trapezoid 4 1 1) 4)

;; integrate-dc : (number -> number) number number -> number
;; Integrates f between left and right
(define (integrate-dc f left right)
  (local ((define mid (/ (+ left right) 2))
          (define area-of-main-trapezoid (area-of-trapezoid (- right left) (f left) (f right)))
          (define area-of-left-half (area-of-trapezoid (- left mid) (f left) (f mid)))
          (define area-of-right-half (area-of-trapezoid (- mid right) (f mid) (f right)))
          (define difference-of-area (- area-of-main-trapezoid (+ area-of-left-half area-of-right-half))))
    (cond
     [(< difference-of-area (* TOLERANCE (- right left))) area-of-main-trapezoid]
     [else (+ (integrate-dc f left mid) (integrate-dc f mid right))])))

;; TESTS

(define TOLERANCE 1/1000)

(define (approximation threshold)
  (lambda (v1 v2) (<= (- v2 v1) threshold)))

(define (approximate? v1 v2)
  (local ((define to-one-tenth (approximation 0.01)))
    (to-one-tenth v1 v2)))

(define (constant x) 1)
(equal? (integrate-dc constant 0 1) 1)
(equal? (integrate-dc constant 2 5) 3)

(define (idempotent x) x)
(approximate? (integrate-dc idempotent 0 1) 1/2)
(approximate? (integrate-dc idempotent 2 4) 6)
