;; distance-to-0 : posn -> number
;; to compute the distance of a posn to the origin
(define (distance-to-0 a-posn)
  (sqrt
  (+ (sqr (posn-x a-posn))
     (sqr (posn-y a-posn)))))

