;; Data Definitions:
(define-struct circle (center radius))
;; A circle is a structure:
;;          (make-circle p s)
;;    where p is a posn, s a number;

(define-struct square (nw length))
;; A square is a structure:
;;          (make-square p s)
;;    where p is a posn, s a number.

;; A shape is either
;; 1. a circle, or
;; 2. a square.

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
     (perimeter-square a-shape)]))

;; perimeter-circle : circle  ->  number
;; to compute the perimeter of a-circle
(define (perimeter-circle a-circle)
  (* (* 2 (circle-radius a-circle)) pi))

;; perimeter-square : square  ->  number
;; to compute the perimeter of a-square
(define (perimeter-square a-square)
  (* (square-length a-square) 4))


