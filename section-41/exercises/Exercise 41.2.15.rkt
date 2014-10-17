#lang racket
(require lang/htdp-advanced)

;; call-status : (vectorof boolean)
;; to keep track of the floors from which calls have been issued 
(define call-status (vector true true true false true true true false))

;; reset-interval : N N  ->  void
;; effect: to set all fields in [from, to] to false
;; assume: (<= from to) holds 
(define (reset-interval from to)
  (reset-interval-aux call-status from to))

(define (reset-interval-aux v from to)
  (cond
   [(> from to) (void)]
   [(<= from to) (begin (vector-set! v from false)
                        (reset-interval-aux v (add1 from) to))]))

;; TESTS
(reset-interval 3 4)
(equal? call-status (vector true true true false false true true false))
(set! call-status (build-vector 8 (lambda (i) true)))
(reset-interval 2 6)
(equal? call-status (vector true true false false false false false true))
