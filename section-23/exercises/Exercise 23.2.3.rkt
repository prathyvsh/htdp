#lang racket
(require lang/htdp-intermediate)

;; make-value : N -> N
(define (make-value n)
  (+ 8 (* 5 n)))

;;; a-fives-closed : N -> N
(define (a-fives-closed n)
  (make-value n))

;; seq-a-fives : N -> (listof N)
;; Creates a sequence of a-fives-closed s
(define (seq-a-fives n)
  (build-list n a-fives-closed))

;; TESTS
(equal? (seq-a-fives 5) (list 8 13 18 23 28))

;; Yes, an arithmetic series can have a sum if the terms are converging
;; towards a fixed number
