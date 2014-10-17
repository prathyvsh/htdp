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

;; distance-between : position position -> number
;; Calculates the distance between two points 
(define (distance-between posn1 posn2)
(sqrt  (+ (sqr (- (posn-x posn2) (posn-x posn1))) (sqr (- (posn-y posn2) (posn-y posn1))))))



;; x-difference : position position -> number
;; Calculates the difference between x values of two points
(define (x-difference posn1 posn2)
  (- (posn-x posn1) (posn-x posn2)))

;; y-difference : position position -> number
;; Calculates the difference between y values of two points
(define (y-difference posn1 posn2)
  (- (posn-y posn1) (posn-y posn2)))

;; draw-a-rectangle : rectangle -> true
;; Draws a given rectangle
(define (in-rectangle? r position)
  (and (< (x-difference position (rectangle-corner r)) (rectangle-width rect))
       (< (y-difference position (rectangle-corner r)) (rectangle-height rect))))


;; TESTS
(define B (make-posn 8 6))
(define C (make-posn 4 4))
(define rect (make-rectangle (make-posn 2 3) 3 2 'blue))

(in-rectangle? rect B) "should be" false
(in-rectangle? rect C) "should be" true
