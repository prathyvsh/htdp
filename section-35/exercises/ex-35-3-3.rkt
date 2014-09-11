#|

(define x 0)
(define (switch-x)
  (begin (set! x (- x 1)) x))

(switch-x)
(switch-x)
(switch-x)

;;

(define x 0)

(begin (set! x (- 0 1)) x)
(switch-x)
(switch-x)

;;

(define x -1)

-1
(begin (set! x (- -1 1)) x)
(switch-x)

;;

(define x -2)

-1
-2
(begin (set! x (- -2 1)) x)

;;

(define x -3)

-1
-2
-3

|#
