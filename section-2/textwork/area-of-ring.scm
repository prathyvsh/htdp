;Area of disk
(define (area-of-disk r)
  (* 3.14 (* r r)))

;Area of ring
(define (area-of-ring outer inner)
  (- (area-of-disk outer)
     (area-of-disk inner)))

;Tests
(area-of-disk 5 3)
