#|
(define-struct ball (x y speed-x speed-y))

(number? (make-ball 1 2 3 4))
false

(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))
(ball-speed-y (make-ball 3 (+ 3 3) 2 3))
(ball-speed-y (make-ball 3 6 2 3))
3

(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))
(ball-y (make-ball 3 6 2 3))
(ball-y (make-ball 3 6 2 3))
6

(number? (make-ball 1 3 4))
error: not enough arguments

(ball-x (make-posn 1 2))
error: not a ball

(ball-speed-y 5)
error: not a ball
|#
