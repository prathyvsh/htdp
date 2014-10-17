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

;; TESTS
(define s (make-square (make-posn 30 20) 40))
(define c (make-circle (make-posn 30 20) 20 40))
(move-square! s 10)
(move-circle! c 10)
(equal? s (make-square (make-posn 40 20) 40))
(equal? c (make-circle (make-posn 40 20) 20 40))
