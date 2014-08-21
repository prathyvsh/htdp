#lang racket
(require lang/htdp-intermediate-lambda)

;; is-prime? : N[>=1] -> boolean
;; to determine whether n is a prime number
(define (is-prime? n)
  ;; accumulator represents the original number
  (local ((define (prime-acc divider acc)
          (cond
           [(<= divider 1) true]
           [else (and (not (= (remainder acc divider) 0))
                      (prime-acc (sub1 divider) acc))])))
    (prime-acc (- n 1) n)))

;; TESTS
(is-prime? 1)
(is-prime? 2)
(is-prime? 3)
(not (is-prime? 4))
(is-prime? 5)
(not (is-prime? 40))
(is-prime? 41)

