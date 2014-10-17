#lang racket
(require lang/htdp-beginner-abbr)

(define (posn=? a-posn another-posn)
  (cond
   [(empty? a-posn) (empty? another-posn)]
   [else (and (= (posn-x a-posn)                 
                 (posn-x another-posn))
              (=(posn-y a-posn)
                (posn-y another-posn)))]))

;; TESTS
(define point1 (make-posn 3 4))
(define point2 (make-posn 5 4))
(define point3 (make-posn 2 3))
(define point4 (make-posn 3 2))
(define point5 (make-posn 3 4))

(not (posn=? point1 point2))
(not (posn=? point2 point3))
(not (posn=? point4 point5))
(posn=? point1 point5)
