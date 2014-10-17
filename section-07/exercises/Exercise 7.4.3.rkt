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

;; translate-shape : shape number -> shape
;; Consumes a shape and moves it to the right delta amount
(define (translate-shape shape delta)
  (cond
  [(circle? shape) (translate-circle shape delta)]
  [(rectangle? shape) (translate-rectangle shape delta)]
  ))


;; move-right : position number -> point
;; Moves point p to the right x pixels
(define (move-right p x)
  (make-posn (+ x (posn-x p)) (posn-y p)))

;; translate-circle circle number -> circle
;; Moves circle to the right by the given delta value
(define (translate-circle circle delta)
  (make-circle (move-right (circle-center circle) delta)
               (circle-radius circle)
               (circle-color circle)))

;; shift-point-right : position number -> position
;; Takes in a position and shifts it delta amount
(define (shift-point-right posn1 delta)
  (make-posn (+ (posn-x posn1) delta)
              (posn-y posn1)))

;; translate-rectangle : rectangle number -> rectangle
;; Consumes a rectangle and produces a new rectangle shifted delta
;; amount
(define (translate-rectangle rect delta)
  (make-rectangle (shift-point-right (rectangle-nw-corner rect) delta)
             (rectangle-width rect)
             (rectangle-height rect)
             (rectangle-color rect)))


;; TESTS
;;
(define rect (make-rectangle (make-posn 50 50) 20 30 'blue))

(define c (make-circle (make-posn 40 80) 30 'pink))

(start 300 300)
(draw-shape rect)
(draw-shape c)

(define moved-rect (translate-shape rect 60))
(define moved-circle (translate-shape c 60))

(draw-shape moved-rect)
(draw-shape moved-circle)
