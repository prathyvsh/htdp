#lang racket
(require lang/htdp-advanced)

;; clean : vector -> void
;; Consumes a vector with three indices and sets
;; them to 0
(define (clean v)
  (begin (vector-set! v 0 0)
         (vector-set! v 1 0)
         (vector-set! v 2 0)))

;; TESTS
(define v (vector 2 3 4))
(clean v)
(equal? v (vector 0 0 0))
