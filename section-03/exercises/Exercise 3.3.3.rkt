#lang racket
(require lang/htdp-beginner)

;; area-cylinder : number number -> number
;; Calculates the surface area of a cylinder
(define (area-cylinder radius height)
    (+ (* 2 (area-of-disk radius)) (* (circumference-of-circle radius) height)))

(define (area-of-disk radius)
  (* (sqr radius) pi))

(define (circumference-of-circle radius)
  (* 2 pi radius))

;; TESTS
(area-cylinder 30 10)
