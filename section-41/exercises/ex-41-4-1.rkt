#lang racket
(require lang/htdp-advanced)
(require htdp/draw)

(define-struct rectangle (corner width height fill))
(define-struct circle (center radius color))

;; draw-a-circle : circle -> true
;; Draws a give circle on screen
(define (draw-a-circle c)
  (draw-circle (circle-center c) (circle-radius c) (circle-color c)))

;; clear-circle : circle -> true
;; Clears the given circle on screen
(define (clear-a-circle c)
  (clear-circle (circle-center c)
                (circle-radius c)
                (circle-color c)))

;; draw-and-clear-circle : circle number -> true
;; Draws a circle c and clears it after 1 second
(define (draw-and-clear-circle c)
  (and (draw-a-circle c)
       (sleep-for-a-while 1)
       (clear-a-circle c)))



;; move-circle : number circle -> circle
;; To draw and clear a circle, translate it by delta pixels
(define (move-circle delta a-circle)
  (cond
    [(draw-and-clear-circle a-circle) (translate-circle a-circle delta)]
    [else a-circle]))

;; draw-a-rectangle : rectangle -> true
;; Draws a given rectangle
(define (draw-a-rectangle r)
  (draw-solid-rect (rectangle-corner r)
                   (rectangle-width r)
                   (rectangle-height r)
                   (rectangle-fill r)))

;; clear-a-rectangle : rectangle -> true
;; Clears a given rectangle from screen
(define (clear-a-rectangle r)
  (clear-solid-rect (rectangle-corner r)
                    (rectangle-width r)
                    (rectangle-height r)
                    (rectangle-fill r)))

;; move-right : position number -> point
;; Moves point p to the right x pixels
(define (move-right p x)
  (set-posn-x! p (+ (posn-x p) x)))

;; translate-rectangle : rectangle number -> rectangle
;; Consumes a rectangle and produces a new rectangle shifted delta
;; amount
(define (translate-rectangle rect delta)
  (begin (move-right (rectangle-corner rect) delta) rect))

;; draw-and-clear-rectangle : rectangle -> true
;; Draws a rectangle and clears it after 1 second
(define (draw-and-clear-rectangle r)
  (and (draw-a-rectangle r)
       (sleep-for-a-while 1)
       (clear-a-rectangle r)))

;; move-rectangle : number rectangle  ->  rectangle
;; To draw and clear a rectangle, translate it by delta pixels
(define (move-rectangle delta a-rectangle)
  (cond
    [(draw-and-clear-rectangle a-rectangle) 
     (translate-rectangle a-rectangle delta)]
    [else a-rectangle]))

;; TESTS
(start 300 300)

(define rect (make-rectangle (make-posn 30 40) 40 50 'blue))
(define crcl (make-circle (make-posn 120 200) 30 'red))

(draw-a-rectangle (move-rectangle 10 rect))
(draw-a-circle (move-circle 10 crcl))
