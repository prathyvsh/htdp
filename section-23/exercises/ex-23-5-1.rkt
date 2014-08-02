#lang racket
(require htdp/graphing)
(require lang/htdp-intermediate)

;;(define (y x) (+ (* a x) b))

(define (line1 x) (+ x 4))
(define (line2 x) (- 4 x))
(define (line3 x) (+ x 10))
(define (line4 x) (- 10 x))
(define (line5 x) 12)

(graph-line line1 'blue)
(graph-line line2 'red)
(graph-line line3 'orange)
(graph-line line4 'cyan)
(graph-line line5 'green)
