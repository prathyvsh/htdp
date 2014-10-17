#lang racket
(require lang/htdp-beginner)

(define-struct square (nw length))
(define-struct circle (center radius))

;; perimeter : shape -> number
;; to compute the perimeter of a-shape
(define (perimeter a-shape)
  (cond
    [(square? a-shape) (* (square-length a-shape) 4)]
    [(circle? a-shape) (* 2 (circle-radius a-shape)pi)]))


;; TESTS

(define sq1 (make-square (make-posn 20 20) 3))
(define sq2 (make-square (make-posn 2 20) 3))
(define cir1(make-circle (make-posn 10 99) 1))

(= (perimeter sq1) 12)
(= (perimeter sq2) 12)
(= (perimeter cir1) (* 2 pi))
