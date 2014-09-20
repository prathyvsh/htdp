#lang racket
(require lang/htdp-advanced)

;; swap-posn : posn -> (void)
(define (swap-posn p)
  (local ((define store (posn-x p)))
    (begin (set-posn-x! p (posn-y p))
    (set-posn-y! p store) p)))

;; TESTS
(define p (make-posn 3 4))
(swap-posn p)
(equal? p (make-posn 4 3))

