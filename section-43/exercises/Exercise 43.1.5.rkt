#lang racket
(require lang/htdp-advanced)

;; vector-reverse! : (vectorof number) -> void
;; Reverses the given vector in place.
(define (vector-reverse! V)
  (local (
          ;; swap : N N -> void
          ;; Swaps the content of i with j in vector
          (define (swap i j)
            (local ((define temp (vector-ref V i)))
              (begin
                (vector-set! V i (vector-ref V j))
                (vector-set! V j temp))))
          
     ;; swap-ends : N N -> void
     ;; Swaps the given locations of the vector
    (define (swap-ends left right)
      (cond
       [(>= left right) (void)]
       [else (begin (swap left right)
                    (swap-ends (add1 left) (sub1 right)))])))
    (begin (swap-ends 0 (sub1 (vector-length V))) V)))

(equal? (vector-reverse! (vector 5 2 3 0 2 1 4))
        (vector 4 1 2 0 3 2 5))

(equal? (vector-reverse! (vector 2 4 0)) (vector 0 4 2))
