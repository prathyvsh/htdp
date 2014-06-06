;Area of disk
(define (area-of-disk r)
  (* 3.14 (* r r)))

;; area-of-ring : number number -> number
;; Computes area of ring with  radius outer and hole with
;; radius inner
(define (area-of-ring outer inner)
  (- (area-of-disk outer)
     (area-of-disk inner)))

;Tests
(area-of-disk 5 3)

