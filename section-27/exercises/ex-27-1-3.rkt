#lang racket
(require lang/htdp-intermediate-lambda)
(require htdp/draw)

;; A triangle is
;; (make-triangle posn posn posn)
(define-struct triangle (a b c))

;; sierpinski : triangle ->  true
;; to draw a Sierpinski triangle down
;; assuming it is large enough
(define (sierpinski tr)
  (cond
    [(too-small? tr) true]
    [else 
      (local ((define a-b (mid-point (triangle-a tr) (triangle-b tr)))
	      (define b-c (mid-point (triangle-b tr) (triangle-c tr)))
	      (define c-a (mid-point (triangle-a tr) (triangle-c tr)))
              (define tr1 (make-triangle (triangle-a tr) a-b c-a))
              (define tr2 (make-triangle (triangle-b tr) a-b b-c))
              (define tr3 (make-triangle (triangle-c tr) c-a b-c)))
	(and
	  (draw-triangle tr)	    
	  (sierpinski tr1)
	  (sierpinski tr2)
	  (sierpinski tr3)))]))

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
(define (draw-triangle tr)
  (and (draw-solid-line (triangle-a tr) (triangle-b tr) 'black)
       (draw-solid-line (triangle-b tr) (triangle-c tr) 'black)
       (draw-solid-line (triangle-a tr) (triangle-c tr) 'black)))

;; too-small? : posn posn posn -> bool
;; Determines if the triangle is too small
;; to draw
(define (too-small? tr)
  (local ((define (distance a b) (sqrt (+ (sqr (- (posn-y b)
                                            (posn-y a)))
                                    (sqr (- (posn-x b)
                                            (posn-x a)))))))
    (or (< (distance (triangle-a tr) (triangle-b tr)) 10)
        (< (distance (triangle-b tr) (triangle-c tr)) 10)
        (< (distance (triangle-c tr) (triangle-a tr)) 10))))

;; TESTS
(start 400 400)
(define A (make-posn 200 0))
(define B (make-posn 27 300))
(define C (make-posn 373 300))
(define tri (make-triangle A B C))
(sierpinski tri)
