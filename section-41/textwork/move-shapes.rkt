;; move-shape! : shape number  ->  void
;; effect: to move a-shape in the x direction by delta pixels
(define (move-shape! a-shape)
  (cond
    [(circle? a-shape) (move-circle a-shape delta)]
    [(square? a-shape) (move-square a-shape delta)]))
