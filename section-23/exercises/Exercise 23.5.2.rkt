#lang racket
(require lang/htdp-intermediate)
(require htdp/graphing)

;; line-from-point+slope : posn number -> (number -> number)
(define (line-from-point+slope point slope)
(local ((define (y x)
 (+ (* slope (- x (posn-x point))) (posn-y point))))
  y))

;; TESTS
(define line1 (line-from-point+slope (make-posn 0 0) 1))
(define line1alt (line-from-point+slope (make-posn 4 4) 1))
(define line2 (line-from-point+slope (make-posn 0 4) 2))

(equal? (line1 10) 10)
(equal? (line1alt 10) 10)
(equal? (line2 10) 24)
  
