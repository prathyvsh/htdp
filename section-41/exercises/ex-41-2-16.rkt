#lang racket
(require lang/htdp-advanced)

;; move! : (vectorof number) (vectorof number)  ->  void
;; effect: to add the fields of v to the corresponding fields of pos 
;; assumption: pos and v have equal length
(define (move! pos v)
  (add-fields-till-zero pos v (vector-length pos)))

;; add-fields-till-zero : (vectorof number) (vectorof number) -> void
;; Adds all the fields correspondingly from each vector
(define (add-fields-till-zero pos v idx)
  (cond
   [(zero? idx) (void)]
   [else (local ((define current-idx (sub1 idx)))
           (begin (vector-set! pos current-idx (+ (vector-ref pos current-idx)
                                        (vector-ref v current-idx)))
                (add-fields-till-zero pos v current-idx)))]))

;; TESTS
(define p (vector 3 4))
(move! p (vector 0 0))
(equal? p (vector 3 4))
(move! p (vector 5 5))
(equal? p (vector 8 9))

(define p2 (vector 5 8 0 2 3 2 1 3))
(move! p2 (vector 1 1 1 1 1 1 1 2))
(equal? p2 (vector 6 9 1 3 4 3 2 5))
