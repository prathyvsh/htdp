(define-struct square (nw length))
(define-struct circle (center radius))


;; area : shape -> number
;; To compute the area of a-shape
(define (area a-shape)
  (cond
    [(square? a-shape) (sqr (square-length a-shape))]
    [(circle? a-shape) (* pi (sqr (circle-radius a-shape)))]))


;; TESTS
(define sq1 (make-square (make-posn 20 20) 3))
(define sq2 (make-square (make-posn 2 20) 4))
(define cir1(make-circle (make-posn 10 99) 1))

(= (area sq1) 9)
(= (area sq2) 16)
(= (area cir1) pi)

;; The same template works since the same data is accessed.
