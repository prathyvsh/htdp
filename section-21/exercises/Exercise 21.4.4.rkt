#lang racket
(require htdp/draw)
(require lang/htdp-intermediate)

;; DATA DEFINITION
(define-struct circle (center radius color))
(define-struct rectangle (corner width height color))

;; A shape is either
;; 1. a structure: (make-circle c r color)
;; where c is a posn, r a number and color a symbol.
;; 2. a structure: (make-rectangle corner w h color)
;; where corner is a posn, w and h a number and color a symbol

;; draw-losh : list of shape -> true
;; Draws a list of gives shapes
(define (draw-losh a-losh)
  (andmap draw-shape a-losh))

;; clear-losh : list-of-shape -> true
;; Clears a list of gives shapes
(define (clear-losh a-losh)
  (andmap clear-shape a-losh))

;; translate-losh : list-of-shape number -> true
;; Translates a list of given shape by delta amount
(define (translate-losh delta a-losh)
  (local ((define (mv-shape shape)
            (translate-shape shape delta)))
  (map mv-shape a-losh)))

;; draw-shape : shape -> true
;; Draws a given shape on the canvas
(define (draw-shape a-shape)
  (process-shape draw-a-rectangle draw-a-circle a-shape))

;; clear-shape : shape -> true
;; Clears a given shape on the canvas
(define (clear-shape a-shape)
  (process-shape clear-a-rectangle clear-a-circle a-shape))

;; translate-shape : shape -> true
;; Clears a given shape on the canvas
(define (translate-shape a-shape delta)
(local ((define (mv-rect r) (translate-rectangle r delta))
        (define (mv-circle c) (translate-circle c delta)))
  (process-shape mv-rect mv-circle a-shape)))

;; process-shape : (rect -> Y) (circle -> Y) shape -> Y
;; Processes a shape with the given function
(define (process-shape rect-fn circle-fn a-shape)
  (cond
   [(circle? a-shape) (circle-fn a-shape)]
   [(rectangle? a-shape) (rect-fn a-shape)]))

;; RECTANGLE FUNCTIONS
;; *******************
;; draw-a-rectangle : rectangle -> true
;; Draws a given rectangle
(define (draw-a-rectangle r)
  (process-rectangle draw-solid-rect r))

;; clear-a-rectangle : rectangle -> true
;; Clears a given rectangle
(define (clear-a-rectangle r)
  (process-rectangle clear-solid-rect r))

;; translate-rectangle : rectangle number -> rectangle
;; Moves rectangle to the right by the given delta value
(define (translate-rectangle r delta)
  (local ((define (translation corner width height color)
            (make-rectangle (move corner delta) width height color)))
  (process-rectangle translation r)))

;; process-rectangle : ((rect-corner rect-width rect-height rect-color) -> Y) rect -> Y
;; Functions to act on a rectangle
(define (process-rectangle fun rect)
  (fun (rectangle-corner rect)
       (rectangle-width rect)
       (rectangle-height rect)
       (rectangle-color rect)))

;; CIRCLE FUNCTIONS
;; ****************
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
  (local ((define (translation center radius color)
            (make-circle (move center delta) radius color)))
  (process-circle c translation)))

;; process-circle
;; Applies a function to all parameters of a circle
(define (process-circle c fun)
  (fun (circle-center c) (circle-radius c) (circle-color c)))

;; COMMON FUNCTIONS
;; ****************
(define (move p x)
  (make-posn (+ x (posn-x p)) (posn-y p)))

;; TESTS
(start 300 300)
(define pink-r (make-rectangle (make-posn 30 30) 20 40 'pink))
(define red-circle (make-circle (make-posn 100 50) 10 'red))
(define green-circle (make-circle (make-posn 150 50) 10 'green))
(define shape-list (list pink-r red-circle green-circle))

(draw-losh shape-list)
(clear-losh shape-list)

(draw-losh shape-list)
(draw-losh (translate-losh 21 shape-list))
