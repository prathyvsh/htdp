#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

;; draw-polygon : polygon -> true
;; to draw the polygon specified by a-poly
(define (draw-polygon a-poly)
  (connect-dots (first a-poly) a-poly))

;; connect-dots : polygon -> true
;; to draw the polygon specified by a-poly
(define (connect-dots a-posn a-poly)
  (cond
    [(empty? (rest a-poly)) (draw-solid-line (first a-poly) a-posn)]
    [else (and (draw-solid-line (first a-poly)  (second a-poly))
          (connect-dots a-posn (rest a-poly)))]))

;; TESTS
(start 300 300)
(define triangle (cons (make-posn 10 10) (cons (make-posn 10 60) (cons (make-posn 60 60) empty))))

(draw-polygon triangle)
