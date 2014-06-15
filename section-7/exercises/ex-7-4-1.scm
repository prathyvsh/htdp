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


