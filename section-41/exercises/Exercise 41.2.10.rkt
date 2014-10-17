#lang racket
(require lang/htdp-advanced)

(define-struct square (nw length))

;; move-squares : (listof square) number -> (void)
;; Moves all the squares in the given list by delta amount
(define (move-squares los delta)
  (cond
   [(empty? los) (void)]
   [else (begin (move-square! (first los) delta)
                (move-squares (rest los) delta))]))

;; move-square! : square number -> (void)
;; Moves the square's x position by delta amount
(define (move-square! sq delta)
  (set-square-nw! sq (make-posn (+ delta (posn-x (square-nw sq))) (posn-y (square-nw sq)))))

;; TESTS
(define sq1 (make-square (make-posn 10 10) 30))
(define sq2 (make-square (make-posn 20 0) 40))
(move-squares (list sq1 sq2) 10)
(equal? sq1 (make-square (make-posn 20 10) 30))
(equal? sq2 (make-square (make-posn 30 0) 40))
