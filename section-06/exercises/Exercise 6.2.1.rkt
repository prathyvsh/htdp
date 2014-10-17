#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

(start 300 300)

(draw-solid-line (make-posn 10 10) (make-posn 110 10) 'red)

(draw-solid-rect (make-posn 10 30) 100 50 'blue)

(draw-circle (make-posn 110 30) 30 'yellow)

(draw-solid-disk (make-posn 10 80) 50 'green)

(stop)

