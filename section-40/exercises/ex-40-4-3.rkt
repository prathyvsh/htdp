#lang racket
(require lang/htdp-advanced)

;; swap : vector -> (void)
(define (swap v)
  (local ((define store (vector-ref v 0)))
    (begin (vector-set! v 0 (vector-ref v 1))
           (vector-set! v 1 store))))

;; TESTS
(define v (vector 1 2))
(swap v)
(equal? v (vector 2 1))
