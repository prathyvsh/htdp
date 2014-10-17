#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

;; rectange is a structure
;; (make-rectangle position number number symbol)
(define-struct rectangle (corner width height fill))

;; Template
;; fun-for-rect : rectange -> ???
;(define (fun-for-rect rect)
;... (rectangle-corner rect) ...
;... (rectangle-width rect) ...
;... (rectangle-height rect) ...
;... (rectangle-fill rect) ...)

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

;; shift-point-right : position number -> position
;; Takes in a position and shifts it delta amount
(define (shift-point-right posn1 delta)
  (make-posn (+ (posn-x posn1) delta)
             (posn-y posn1)))

;; translate-rectangle : rectangle number -> rectangle
;; Consumes a rectangle and produces a new rectangle shifted delta
;; amount
(define (translate-rectangle rect delta)
  (make-rectangle (shift-point-right (rectangle-corner rect) delta)
                  (rectangle-width rect)
                  (rectangle-height rect)
                  (rectangle-fill rect)))

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
(draw-a-rectangle (move-rectangle 10 (move-rectangle 10 (move-rectangle 10 (move-rectangle 10 rect))))) 
