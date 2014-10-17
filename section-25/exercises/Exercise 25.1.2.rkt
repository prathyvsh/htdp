#lang racket
(require lang/htdp-intermediate-lambda)
(require htdp/draw)

;; A ball is a structure: 
;;   (make-ball number number number number)
(define-struct ball (x y delta-x delta-y color))

;; draw-and-clear-balls : (listof ball)  ->  true
;; draw, sleep, clears balls from the given list on canvas
(define (draw-and-clear-balls ball-list)
  (local ((define (get-location ball) (make-posn (ball-x ball) (ball-y ball)))
          (define radius 5)
          (define (draw-ball ball) (draw-solid-disk (get-location ball) radius (ball-color ball)))
          (define (clear-ball ball) (clear-solid-disk (get-location ball) radius)))
    (and (andmap draw-ball ball-list)
         (sleep-for-a-while DELAY)
         (andmap clear-ball ball-list))))

;; move-ball : ball  ->  ball
;; to create a new ball, modeling a move by a-ball
(define (move-ball a-ball) 
  (make-ball (+ (ball-x a-ball) (ball-delta-x a-ball))
             (+ (ball-y a-ball) (ball-delta-y a-ball))
             (ball-delta-x a-ball)
             (ball-delta-y a-ball)
             (ball-color a-ball)))

;; out-of-bounds? : a-ball  ->  boolean
;; to determine whether a-ball is outside of the bounds
;; domain knowledge, geometry
(define (out-of-bounds? a-ball)
  (not
   (and
    (<= 0 (ball-x a-ball) WIDTH)
    (<= 0 (ball-y a-ball) HEIGHT))))

;; move-balls : (listof balls) -> true
(define (move-balls ball-list)
  (local ((define (in-bounds? x) (not (out-of-bounds? x)))
          (define balls-in-bound (filter in-bounds? ball-list))
          (define moved-balls (map move-ball balls-in-bound)))
    (cond [(empty? balls-in-bound) true]
          [else  (and (draw-and-clear-balls balls-in-bound)
                      (move-balls moved-balls))])))

;; Dimension of canvas 
(define WIDTH 300)
(define HEIGHT 300)
(define DELAY 1/60) ;For 60FPS

(define ball-list (list (make-ball 10 20 3 4 'navy)
                        (make-ball 30 40 1 2 'red)
                        (make-ball 12 50 2 4 'pink)
                        (make-ball 80 12 -3 -4 'green)
                        (make-ball 60 60 12 3 'orange)
                        (make-ball 30 20 -8 1 'cyan)
                        (make-ball 100 10 -1 -4 'indigo)))

(start WIDTH HEIGHT)
(move-balls ball-list)
(stop)
