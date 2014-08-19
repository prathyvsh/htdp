#lang racket
(require lang/htdp-intermediate-lambda)

;; vector-contains-doll? : vector -> boolean
(define (vector-contains-doll? vec)
  (local ((define (check-vec-for-doll i)
            (cond
             [(zero? i) false]
             [else (or (symbol=? 'Doll (vector-ref vec (sub1 i)))
                  (check-vec-for-doll (sub1 i)))])))
          (check-vec-for-doll (vector-length vec))))

;; TESTS
(not (vector-contains-doll? (vector 'Robot 'Ken 'Barbie)))
(vector-contains-doll? (vector 'Robot 'Ken 'Doll 'Barbie))

