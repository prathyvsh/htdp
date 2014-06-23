;; DATA DEFINITION
(define-struct circle (center radius color))
(define-struct rectangle (nw-corner width height color))
;; A shape is either
;; 1. a structure: (make-circle c r color)
;; where c is a posn, r a number and color a symbol.
;; 2. a structure: (make-rectangle corner w h color)
;; where corner is a posn, w and h a number and color a symbol

;; A list of shapes consists of either:
;; 1. empty
;; 2. (cons shape list of shape) where a shape can be a circle or rectangle struct

;; translate-losh : list-of-shape number -> true
;; Translates a list of given shape by delta amount
(define (translate-losh delta a-losh)
  (cond
    [(empty? a-losh) empty]
    [else (cons (translate-shape delta (first a-losh))
               (translate-losh delta (rest a-losh)))]))

;; translate-shape : shape number -> shape
;; Consumes a shape and moves it to the right delta amount
(define (translate-shape delta shape)
  (cond
  [(circle? shape) (translate-circle delta shape)]
  [(rectangle? shape) (translate-rectangle delta shape)]
  ))


;; move-right : position number -> point
;; Moves point p to the right x pixels
(define (move-right p x)
  (make-posn (+ x (posn-x p)) (posn-y p)))

;; translate-circle circle number -> circle
;; Moves circle to the right by the given delta value
(define (translate-circle delta circle)
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
(define (translate-rectangle delta rect)
  (make-rectangle (shift-point-right (rectangle-nw-corner rect) delta)
             (rectangle-width rect)
             (rectangle-height rect)
             (rectangle-color rect)))

;; TESTS
(define FACE (cons (make-circle (make-posn 50 50) 40 'red)
                   (cons (make-rectangle (make-posn 30 20) 5 5 'blue)
                         (cons (make-rectangle (make-posn 65 20) 5 5 'blue)
                               (cons (make-rectangle (make-posn 40 75) 20 10 'red)
                                     (cons (make-rectangle (make-posn 45 35) 10 30 'blue) empty))))))

(translate-losh 10 FACE) "should be"

(cons (make-circle (make-posn 60 50) 40 'red)
                   (cons (make-rectangle (make-posn 40 20) 5 5 'blue)
                         (cons (make-rectangle (make-posn 75 20) 5 5 'blue)
                               (cons (make-rectangle (make-posn 50 75) 20 10 'red)
                                     (cons (make-rectangle (make-posn 55 35) 10 30 'blue) empty)))))
