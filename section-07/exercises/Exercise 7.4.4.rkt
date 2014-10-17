#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
(define-struct circle (center radius color))
(define-struct rectangle (nw-corner width height color))
;; A shape is either
;; 1. a structure: (make-circle c r color)
;; where c is a posn, r a number and color a symbol.
;; 2. a structure: (make-rectangle corner w h color)
;; where corner is a posn, w and h a number and color a symbol
#|
;;TEMPLATE
(define (fun-for-shape shape)
  (cond
    [(circle? shape)
     ... (circle-center shape)
     ... (circle-radius shape)
     ... (circle-color shape) ...]
    [(rectangle? shape)
     ... (rectangle-nw-corner shape)
     ...  (rectangle-width shape)
     ...  (rectangle-height shape)
     ...  (rectangle-color shape) ...]
    ))
|#

;; draw-shape : shape -> true
;; Draws a given shape on the canvas
(define (draw-shape a-shape)
  (cond
    [(circle? a-shape)
     (draw-circle (circle-center a-shape) (circle-radius a-shape) (circle-color a-shape))]
    [(rectangle? a-shape)
     (draw-solid-rect (rectangle-nw-corner a-shape)  (rectangle-width a-shape) (rectangle-height a-shape) (rectangle-color a-shape))]
))

;; clear-shape : shape -> true
;; Clears a given shape on the canvas
(define (clear-shape a-shape)
  (cond
    [(circle? a-shape)
     (clear-circle (circle-center a-shape) (circle-radius a-shape) (circle-color a-shape))]
    [(rectangle? a-shape)
     (clear-solid-rect (rectangle-nw-corner a-shape)  (rectangle-width a-shape) (rectangle-height a-shape) (rectangle-color a-shape))]
))

;; TESTS
(define rect (make-rectangle (make-posn 30 50) 20 30 'blue))
(define c (make-circle (make-posn 40 20) 30 'pink))

(start 200 200)
(draw-shape rect)
(draw-shape c)
(clear-shape rect)
(clear-shape c)

