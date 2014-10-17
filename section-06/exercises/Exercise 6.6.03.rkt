#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

;;circle ->
(define-struct circle (center radius color))

;; TEMPLATE
;;(define (fun-for-circle a-circle)
;;  ... (circle-center a-circle) ...
;;  ... (circle-radius a-circle) ...
;;  ... (circle-perimeter a-circle) ...)

;; distance-between : position position -> number
;; Calculates the distance between two points 
(define (distance-between posn1 posn2)
(sqrt  (+ (sqr (- (posn-x posn2) (posn-x posn1))) (sqr (- (posn-y posn2) (posn-y posn1))))))

;; in-circle? : circle position -> bool
;; Determines if a given position is inside the circle
(define (in-circle? circle posn)
  (<= (distance-between (circle-center circle) posn) (circle-radius circle)
      ))

;;TESTS

(define center1 (make-posn 6 2))
(define radius1 1)
(define circle1 (make-circle center1 radius1 'red))
(define posnA (make-posn 6 1.5))
(define posnB (make-posn 8 6))

(in-circle? circle1 posnA) "should be" true
(in-circle? circle1 posnB) "should be" false

