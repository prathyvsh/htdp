#lang racket
(require lang/htdp-intermediate-lambda)

;; vector-count : vector symbol -> number
;; Determines the number of times symbol occurs in vector.
(define (vector-symbol-count v s)
  (local ((define (symbol-in-vec? index) (symbol=? (vector-ref v index) s))
    (define (count i)
    (cond
     [(= i 0) 0]
     [else (+ (if (symbol-in-vec? (sub1 i)) 1 0) (count (sub1 i)))])))
  (count (vector-length v))))

;; TESTS
(equal? (vector-symbol-count (vector 'Doll 'Ball 'Drone 'Phone 'Cone) 'Ball) 1)
(equal? (vector-symbol-count (vector 'Ball 'Ball 'Ball 'Phone 'Ball) 'Ball) 4)

