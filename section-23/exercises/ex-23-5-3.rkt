#lang racket
(require lang/htdp-intermediate)
(require htdp/graphing)

(define (y x)
  (+ (- (* x x) (* 4 x)) 7))


;; line-from-point+slope : posn number -> (number -> number)
(define (line-from-point+slope point slope)
  (local ((define (y x)
            (+ (* slope (- x (posn-x point))) (posn-y point))))
    y))

(define (calc-slope fn x e)
  (/ (- (fn (+ x e)) (fn (- x e))) (* 2 e)))

(graph-fun y 'red)
(define x1 2)
(define e1 1)
(define slope1 (calc-slope y x1 e1))
slope1
(graph-line (line-from-point+slope (make-posn x1 (y x1)) slope1) 'blue)

(define x2 4)
(define e2 2)
(define slope2 (calc-slope y x2 e2))
slope2
(graph-line (line-from-point+slope (make-posn x2 (y x2)) slope2) 'gray)