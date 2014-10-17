#lang racket
(require lang/htdp-intermediate-lambda)
(require htdp/draw)

(define CENTER (make-posn 200 200))

(define RADIUS 200)

;; circle-pt : number  ->  posn
;; to compute a position on the circle with CENTER
;; and RADIUS as defined above 
(define (circle-pt factor)
  (make-posn (+ (posn-x CENTER)
                (* RADIUS (sin (* 2 pi factor))))
             (+ (posn-y CENTER)
                (* RADIUS (cos (* 2 pi factor))))))

;; draw-triangle : posn posn posn -> true
;; Draws a triangle connecting the points a,b and c
(define (draw-triangle a b c)
  (and (draw-solid-line a b 'black)
       (draw-solid-line b c 'black)
       (draw-solid-line a c 'black)))


;; TEST
(start 400 400)
(draw-circle CENTER RADIUS 'blue)
(define A (circle-pt 120/360))
(define B (circle-pt 240/360))
(define C (circle-pt 0/360))
(draw-triangle A B C)
