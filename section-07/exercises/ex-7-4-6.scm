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

;; draw-and-clear-shape : shape -> true
;; Draws a given a-shape and clears it after 1 second
(define (draw-and-clear-shape a-shape)
  (and (draw-shape a-shape)
       (sleep-for-a-while 1)
       (clear-shape a-shape)))

;; move-shape : shape -> true
;; Draws and clears the shape on the screen and then return a shape translated by delta amount
(define (move-shape delta a-shape)
  (cond
  [(draw-and-clear-shape a-shape) (translate-shape a-shape)]
  [else a-shape]))

;; TESTS
(define rect (make-rectangle (make-posn 30 50) 20 30 'blue))
(define c (make-circle (make-posn 40 20) 30 'pink))

(start 200 200)
(move-shape 20 (move-shape 20 (move-shape 20 (move-shape 20 rect))))
(move-shape 20 (move-shape 20 (move-shape 20 (move-shape 20 c))))
