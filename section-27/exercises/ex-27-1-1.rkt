#lang racket
(require lang/htdp-intermediate-lambda)
(require htdp/draw)

;; sierpinski : posn posn posn  ->  true
;; to draw a Sierpinski triangle down at a, b, and c,
;; assuming it is large enough
(define (sierpinski a b c)
  (cond
    [(too-small? a b c) true]
    [else 
      (local ((define a-b (mid-point a b))
	      (define b-c (mid-point b c))
	      (define c-a (mid-point a c)))
	(and
	  (draw-triangle a b c)	    
	  (sierpinski a a-b c-a)
	  (sierpinski b a-b b-c)
	  (sierpinski c c-a b-c)))]))

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

;; draw-triangle : posn posn posn -> true
;; Draws a triangle connecting the points a,b and c
(define (draw-triangle a b c)
  (and (draw-solid-line a b 'black)
       (draw-solid-line b c 'black)
       (draw-solid-line a c 'black)))

;; too-small? : posn posn posn -> bool
;; Determines if the triangle is too small
;; to draw
(define (too-small? a b c)
  (local ((define (distance a b) (sqrt (+ (sqr (- (posn-y b)
                                            (posn-y a)))
                                    (sqr (- (posn-x b)
                                            (posn-x a)))))))
    (or (< (distance a b) 10)
        (< (distance b c) 10)
        (< (distance c a) 10))))

;; TESTS
(start 400 400)
(define A (make-posn 200 0))
(define B (make-posn 27 300))
(define C (make-posn 373 300))
(sierpinski A B C)
