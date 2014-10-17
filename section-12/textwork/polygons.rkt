;; A polygon is either
;; (cons posn empty)
;; (cons posn list-of-posns)

#|
;; TEMPLATE
(define (draw-polygon a-poly)
  (cond
    [(empty? (rest a-poly)) ... (first a-poly) ...]
    [else ... (first a-poly) ...  (second a-poly) ... 
          (draw-polygon (rest a-poly)) ...]))
#|

;; draw-polygon : polygon -> true
;; to draw the polygon specified by a-poly
(define (draw-polygon a-poly)
  (connect-dots (cons (last a-poly) a-poly)))

;; connect-dots : polygon -> true
;; to draw the polygon specified by a-poly
(define (connect-dots a-poly)
  (cond
    [(empty? (rest a-poly)) true]
    [else (and (draw-solid-line (first a-poly)  (second a-poly))
          (connect-dots (rest a-poly)))]))

;; last : polygon -> posn
;; to extract the last posn on a-poly
(define (last a-poly)
  (cond
    [(empty? (rest a-poly)) (first a-poly)]
    [else (last (rest a-poly))]))
