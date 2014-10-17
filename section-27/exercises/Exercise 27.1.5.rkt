#lang racket
(require lang/htdp-intermediate-lambda)
(require htdp/draw)

;; A triangle is
;; (make-triangle posn posn posn)
(define-struct triangle (p1 p2 p3))

;; distance : posn posn -> number
;; Determines the distance between two posns
(define (distance a b) (sqrt (+ (sqr (- (posn-y b) (posn-y a)))
                                (sqr (- (posn-x b) (posn-x a))))))

;; draw-bezier : triangle -> true
(define (draw-bezier t)
  (local ((define mid1 (mid-point (triangle-p1 t) (triangle-p2 t)))
          (define mid2 (mid-point (triangle-p2 t) (triangle-p3 t)))
          (define new-mid (mid-point mid1 mid2)))
    (cond
     [(< (distance mid1 mid2) 3) (draw-triangle (triangle-p1 t)
                                                (triangle-p2 t)
                                                (triangle-p3 t))]
     [else (and (draw-bezier (make-triangle (triangle-p1 t) mid1 new-mid))
                (draw-bezier (make-triangle new-mid mid2 (triangle-p3 t))))])))


;; draw-triangle : posn posn posn -> true
;; Draws a triangle connecting the points a,b and c
(define (draw-triangle a b c)
  (and (draw-solid-line a b 'black)
       (draw-solid-line b c 'black)
       (draw-solid-line a c 'black)))

;; mid-point : posn posn  ->  posn
;; to compute the mid-point between a-posn and b-posn
(define (mid-point a-posn b-posn)
  (make-posn
   (mid (posn-x a-posn) (posn-x b-posn))
   (mid (posn-y a-posn) (posn-y b-posn))))

;; mid : number number  ->  number
;; to compute the average of x and y
(define (mid x y)
  (/ (+ x y) 2))


;; TESTS
(define p1 (make-posn 50 50))
(define p2 (make-posn 150 150))
(define p3 (make-posn 250 100))

(start 300 300)
(draw-bezier (make-triangle p1 p2 p3))

(draw-bezier (make-triangle (make-posn 0 0)
                            (make-posn 0 150)
                            (make-posn 300 300)))


