#lang racket
(require lang/htdp-intermediate)
(require htdp/draw)

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

;; draw-losh : list of shape -> true
;; Draws a list of gives shapes
(define (draw-losh a-losh)
  (cond
   [(empty? a-losh) true]
   [else (and (local (
                      ;; draw-shape : shape -> true
                      ;; Draws a given shape on the canvas
                      (define (draw-shape a-shape)
                        (cond
                         [(circle? a-shape)
                          (draw-circle (circle-center a-shape)
                                       (circle-radius a-shape)
                                       (circle-color a-shape))]
                         [(rectangle? a-shape)
                          (draw-solid-rect (rectangle-nw-corner a-shape)
                                           (rectangle-width a-shape)
                                           (rectangle-height a-shape)
                                           (rectangle-color a-shape))]
                         )))
                (draw-shape (first a-losh)))
              (draw-losh (rest a-losh)))]))

;; clear-losh : list-of-shape -> true
;; Clears a list of gives shapes
(define (clear-losh a-losh)
  (cond
   [(empty? a-losh) true]
   [else (and (local (
                      ;; clear-shape : shape -> true
                      ;; Clears a given shape on the canvas
                      (define (clear-shape a-shape)
                        (cond
                         [(circle? a-shape)
                          (clear-circle (circle-center a-shape)
                                        (circle-radius a-shape)
                                        (circle-color a-shape))]
                         [(rectangle? a-shape)
                          (clear-solid-rect (rectangle-nw-corner a-shape)
                                            (rectangle-width a-shape)
                                            (rectangle-height a-shape)
                                            (rectangle-color a-shape))])))
                (clear-shape (first a-losh)))
              (clear-losh (rest a-losh)))]))

;; move-picture : delta picture -> true
(define (move-picture delta picture)
  (local (
          ;; draw-and-clear-picture : list-of-shape -> true
          ;; Draws and clears a picture from the screen.
          (define (draw-and-clear-picture pic)
            (and (draw-losh pic)
                 (sleep-for-a-while 1)
                 (clear-losh pic))))
    (cond
     [(draw-and-clear-picture picture) (translate-losh delta picture)]
     [else picture])))


;; translate-losh : list-of-shape number -> true
;; Translates a list of given shape by delta amount
(define (translate-losh delta a-losh)
  (cond
   [(empty? a-losh) empty]
   [else (cons (local (
                       ;; translate-shape : shape number -> shape
                       ;; Consumes a shape and moves it to the right delta amount
                       (define (translate-shape delta shape)
                         (local (
                                 ;; translate-circle circle number -> circle
                                 ;; Moves circle to the right by the given delta value
                                 (define (translate-circle delta circle)
                                   (local (
                                           ;; move-right : position number -> point
                                           ;; Moves point p to the right x pixels
                                           (define (move-right p x)
                                             (make-posn (+ x (posn-x p)) (posn-y p))))
                                     (make-circle (move-right (circle-center circle) delta)
                                                  (circle-radius circle)
                                                  (circle-color circle))))

                                 ;; translate-rectangle : rectangle number -> rectangle
                                 ;; Consumes a rectangle and produces a new rectangle shifted delta
                                 ;; amount
                                 (define (translate-rectangle delta rect)
                                   (make-rectangle (local (
                                                           ;; shift-point-right : position number -> position
                                                           ;; Takes in a position and shifts it delta amount
                                                           (define (shift-point-right posn1 delta)
                                                             (make-posn (+ (posn-x posn1) delta)
                                                                        (posn-y posn1))))
                                                     (shift-point-right (rectangle-nw-corner rect) delta))
                                                   (rectangle-width rect)
                                                   (rectangle-height rect)
                                                   (rectangle-color rect)))

                                 )
                           (cond
                            [(circle? shape) (translate-circle delta shape)]
                            [(rectangle? shape) (translate-rectangle delta shape)]
                            ))))
                 (translate-shape delta (first a-losh)))
               (translate-losh delta (rest a-losh)))]))


;; TESTS
(define FACE (cons (make-circle (make-posn 50 50) 40 'red)
                   (cons (make-rectangle (make-posn 30 20) 5 5 'blue)
                         (cons (make-rectangle (make-posn 65 20) 5 5 'blue)
                               (cons (make-rectangle (make-posn 40 75) 20 10 'red)
                                     (cons (make-rectangle (make-posn 45 35) 10 30 'blue) empty))))))

(start 300 300)

(draw-losh
 (move-picture -5 
               (move-picture 23
                             (move-picture 10 FACE))))

(stop) 
