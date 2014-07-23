#lang racket
(require lang/htdp-intermediate)

;; natural-f : Y (X -> Y) X N -> Y
(define (natural-f base fn item n)
  (cond
   [(zero? n) base]
   [else (fn item (natural-f base fn item (sub1 n)))]))

;; copy : N X  ->  (listof X)
;; to create a list that contains
;; obj n times
(define (copy n obj)
  (natural-f empty cons obj n))

;; n-adder : N number  ->  number
;; to add n to x using
;; (+ 1 ...) only
(define (n-adder n x)
  (natural-f x + 1 n))

;; n-multiplier : N number  ->  number
;; to multiply x by n using addition only
(define (n-multiplier n x)
  (natural-f 0 + x n))


;; TESTS
(equal? (copy 0 'symbol) empty)
(equal? (copy 3 'symbol) (list 'symbol 'symbol 'symbol))
(equal? (n-adder 3 4) 7)
(equal? (n-multiplier 3 4) 12)
