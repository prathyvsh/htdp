;; distance-to-0 : pixel-2 -> number
;; to compute the distance of a p-pixel to the origin
(define (distance-to-0 a-pixel) 
  (cond
    [(number? a-pixel) a-pixel]
    [(posn? a-pixel) (sqrt (+ (sqr (posn-x a-pixel)) (sqr (posn-y a-pixel))))]))

;; perimeter : shape -> number
;; to compute the perimeter of a-shape
(define (perimeter a-shape)
  (cond
    [(square? a-shape) (* (square-length a-shape) 4)]
    [(circle? a-shape) (* (* 2 (circle-radius a-shape)) pi)]))



