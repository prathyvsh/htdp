#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

;; A circle is a structure:
;; (make-circle position number color)
(define-struct circle (center radius color))

;; draw-a-circle : circle -> true
;; Draws a given circle on screen
(define (draw-a-circle c)
  (draw-circle (circle-center c) (circle-radius c) (circle-color c)))

;; TESTS
(start 300 300)
(draw-a-circle (make-circle (make-posn 50 50) 10 'red))
