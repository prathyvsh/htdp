
;; draw-polygon : polygon -> true
;; to draw the polygon specified by a-poly
(define (draw-polygon a-poly)
  (connect-dots (add-at-end (first a-poly) a-poly)))

;; connect-dots : polygon -> true
;; to draw the polygon specified by a-poly
(define (connect-dots a-poly)
  (cond
    [(empty? (rest a-poly)) true]
    [else (and (draw-solid-line (first a-poly)  (second a-poly))
          (connect-dots (rest a-poly)))]))

;; add-at-end : position polygon -> posn
;; Adds the first position of the polygon at it's end
(define (add-at-end a-posn a-poly)
  (cond
    [(empty? (rest a-poly)) (cons (first a-poly) (cons a-posn empty))]
    [else (cons (first a-poly) (add-at-end a-posn (rest a-poly)))]))

;; TESTS
(start 300 300)
(define triangle (cons (make-posn 10 10) (cons (make-posn 10 60) (cons (make-posn 60 60) empty))))

(add-at-end (first triangle) triangle) "should be" (cons (make-posn 10 10) (cons (make-posn 10 60) (cons (make-posn 60 60) (cons (make-posn 10 10) empty))))
(draw-polygon triangle)
