#lang racket
(require lang/htdp-beginner)

;; Data Definitions:
(define-struct circle (center radius))
;; A circle is a structure:
;;          (make-circle p s)
;;    where p is a posn, s a number;

(define-struct square (nw length))
;; A square is a structure:
;;          (make-square p s)
;;    where p is a posn, s a number.


(define-struct rectangle (nw height width))
;; A square is a structure:
;;          (make-rectangle c h w)
;;    where c is a posn, h and w a number.

;; A shape is either
;; 1. a circle, or
;; 2. a square, or
;; 3. a rectangle

;; distance-to-0 : pixel-2 -> number
;; to compute the distance of a p-pixel to the origin
(define (distance-to-0 a-pixel) 
  (cond
    [(number? a-pixel) a-pixel]
    [(posn? a-pixel) (sqrt (+ (sqr (posn-x a-pixel)) (sqr (posn-y a-pixel))))]))

;; Final Definitions: 
;; perimeter : shape  ->  number
;; to compute the perimeter of a-shape
(define (perimeter a-shape)
  (cond
    [(circle? a-shape)
     (perimeter-circle a-shape)]
    [(square? a-shape)
     (perimeter-square a-shape)]
    [(rectangle? a-shape)
     (perimeter-rectangle a-shape)]))

;; perimeter-circle : circle  ->  number
;; to compute the perimeter of a-circle
(define (perimeter-circle a-circle)
  (* (* 2 (circle-radius a-circle)) pi))

;; perimeter-square : square  ->  number
;; to compute the perimeter of a-square
(define (perimeter-square a-square)
  (* (square-length a-square) 4))

;; perimeter-rectangle : rectangle  ->  number
;; to compute the perimeter of a-rectangle
(define (perimeter-rectangle a-rectangle)
  (* 2 (+ (rectangle-width a-rectangle) (rectangle-height a-rectangle))))


;; perimeter : shape  ->  number
;; to compute the perimeter of a-shape
(define (perimeter-2 a-shape)
  (cond
    [(circle? a-shape)
     (* (* 2 (circle-radius a-shape)) pi)]
    [(square? a-shape)
     (* (square-length a-shape) 4)]
    [(rectangle? a-shape)
      (* 2 (+ (rectangle-width a-shape) (rectangle-height a-shape)))]))

;; TESTS
(define rect (make-rectangle (make-posn 3 2) 5 10))
(= (perimeter-rectangle rect) 30)
