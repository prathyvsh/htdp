#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
(define (draw-circles position list-of-radii)
  (... (first list-of-radii) ... (draw-circles position (rest list-of-radii)) ...))
|#

;; draw-circles : list-of-points number -> true
(define (draw-circles position list-of-radii)
  (and (draw-circle position (first list-of-radii)) (draw-circles position (rest list-of-radii))))

;; TESTS
(start 300 300)
(define radii (cons 10 (cons 20 (cons 30 empty)))) 

(draw-circles (make-posn 150 150) radii)
