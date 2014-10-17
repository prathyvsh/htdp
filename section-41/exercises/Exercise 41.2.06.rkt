#lang racket
(require lang/htdp-advanced)

(define-struct square (nw length))
(define-struct circle (center radius color))

;; move-square! : square number -> (void)
;; Moves the square's x position by delta amount
(define (move-square! sq delta)
  (set-square-nw! sq (make-posn (+ delta (posn-x (square-nw sq))) (posn-y (square-nw sq)))))

;; move-circle! : circle number -> (void)
;; Moves the circle's x position by delta amount
(define (move-circle! c delta)
  (set-circle-center! c (make-posn (+ delta (posn-x (circle-center c))) (posn-y (circle-center c)))))

;; move-shape! : shape number  ->  void
;; effect: to move a-shape in the x direction by delta pixels
(define (move-shape! a-shape delta)
  (cond
    [(circle? a-shape) (move-circle! a-shape delta)]
    [(square? a-shape) (move-square! a-shape delta)]))

;; TESTS
(define s (make-square (make-posn 2 3) 30))
(define c (make-circle (make-posn 20 10) 30 20))

(map (lambda (x) (move-shape! x 10)) (list s c))
(equal? s (make-square (make-posn 12 3) 30))
(equal? c (make-circle (make-posn 30 10) 30 20))
