(define x 3)
(define y 5)
(begin (set! x y)
       (set! y x)
       (list x y))

We can distinguish 4 time periods
in this evaluation.

;; Before evaluation of (set! x y)
(define x 3)
(define y 5)
(begin (set! x 5)
       (set! y x)
       (list x y))

;; After evaluation of (set! x y)
(define x 5)
(define y 5)
(begin (void) (set! y x) (list x y))

;; Before evaluation of (set! x y)
(define x 5)
(define y 5)
(begin (void) (set! y 5) (list x y))

;; After evaluation of (set! x y)
(define x 5)
(define y 5)
(begin (void) (void) (list 5 5))

(define x 3)
(define y 5)
(local ((define z x))
  (begin (set! x y) (set! y z)
         (list x y)))

;; Yes the values are always swapped.
;; The examples illustrates that if a
;; proxy is not employed to store the
;; original value of x, it will be lost
;; when it is replaced with another value.


