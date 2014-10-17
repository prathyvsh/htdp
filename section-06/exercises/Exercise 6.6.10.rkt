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

;; TESTS
(define rect (make-rectangle (make-posn 2 3) 3 2 'blue))
(define new-rect (translate-rectangle rect 30))
(= (posn-x (rectangle-corner new-rect)) 32)
