#lang racket
(require lang/htdp-beginner)

;; is-no-divisible-by<=i : N[>=1] N[>=2] -> boolean
;; Determines if m is divisible by a number in the interval (1, i]
(define (is-not-divisible-by<=i i m)
  (cond
  [(= i 1) true]
  [else (and (not (= (remainder m i) 0))
             (is-not-divisible-by<=i (sub1 i) m))]))

;; prime : N -> boolean
;; Determines if the given number is prime or not
(define (prime? n)
  (cond
    [(= n 1) true]
    [else (is-not-divisible-by<=i (quotient n 2) n)]))

;; TESTS
(boolean=? (is-not-divisible-by<=i 2 5) true)
(boolean=? (is-not-divisible-by<=i 2 6) false)
(boolean=? (is-not-divisible-by<=i 3 10) false)
(boolean=? (is-not-divisible-by<=i 3 11) true)

(boolean=? (prime? 1) true)
(boolean=? (prime? 2) true)
(boolean=? (prime? 3) true)
(boolean=? (prime? 4) false)
(boolean=? (prime? 5) true)
(boolean=? (prime? 15) false)
(boolean=? (prime? 19) true)
(boolean=? (prime? 53) true)
