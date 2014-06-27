;; A polygon is either
;; (cons posn empty)
;; (cons posn list-of-posns)
;;
;; TEMPLATE
;; draw-polygon : polygon -> true
;; to draw the polygon specified by a-poly
(define (draw-polygon a-poly)
  (cond
    [(empty? (rest a-poly)) ... (first a-poly) ...]
    [else ... (first a-poly) ...  (second a-poly) ... 
          (draw-polygon (rest a-poly)) ...]))
