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

;; TESTS
(define rect (make-rectangle (make-posn 3 5) 20 30 'blue))
(define c (make-circle (make-posn 10 20) 30 'pink))

(start 200 200)
(draw-shape rect)
(draw-shape c)
