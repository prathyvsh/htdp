#lang racket
(require lang/htdp-beginner)

(define-struct vec (x y))

(define (checked-make-vec x y)
  (cond
  [(and (> x 0) (> y 0)) (make-vec x y)]
  [else (error 'checked-make-vec "Requires positive number for both x and y")]
  ))

;; TESTS
(checked-make-vec 3 5)
(checked-make-vec 3 -5)
