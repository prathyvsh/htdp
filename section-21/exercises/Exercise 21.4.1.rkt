#lang racket
(require lang/htdp-intermediate)
(require htdp/draw)

;; A circle is a structure:
;; (make-circle position number color)
(define-struct circle (center radius color))

;; draw-a-circle : circle -> true
;; Draws a given circle on screen
(define (draw-a-circle c)
  (process-circle c draw-circle))

;; clear-a-circle : circle -> true
;; Clears a given circle on scree 
(define (clear-a-circle c)
  (process-circle c clear-circle))

;; translate-circle : circle number -> circle
;; Moves circle to the right by the given delta value
(define (translate-circle c delta)
  (local ((define (move-right p x)
            (make-posn (+ x (posn-x p)) (posn-y p)))
          (define (translation center radius color)
            (make-circle (move-right center delta) radius color)))
  (process-circle c translation)))

;; process-circle : circle (circle -> Y) -> Y
;; Applies a function to all parameters of a circle
(define (process-circle c fun)
  (fun (circle-center c) (circle-radius c) (circle-color c)))

;; TESTS
(start 300 300)
(draw-a-circle (make-circle (make-posn 50 50) 10 'red))
(clear-a-circle (make-circle (make-posn 50 50) 10 'red))

(draw-a-circle (make-circle (make-posn 50 50) 10 'green))
(draw-a-circle (translate-circle (make-circle (make-posn 50 50) 10 'green) 20))
