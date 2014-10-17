#|
(define x 3)
(define (increase-x)
  (begin set! x (+ x 1) x))

(increase-x)
(increase-x)
(increase-x)

(define x 3)
(define (increase-x)
  (begin (set! x (+ x 1)) x))

(begin (set! x (+ 3 1)) 3)
(increase-x)
(increase-x)

;;;;

(define x 4)
(define (increase-x)
  (begin (set! x (+ x 1)) x))

(begin (void) 4)
(increase-x)
(increase-x)

;;;;

(define x 5)
(define (increase-x)
  (begin (set! x (+ x 1)) x))

4
(begin (void) 5)
(increase-x)

;;;;

(define x 6)
(define (increase-x)
  (begin (set! x (+ x 1)) x))

4
5
(begin (void) 6)

;;;;

(define x 6)
(define (increase-x)
  (begin (set! x (+ x 1)) x))

4
5
6

|#
