#lang racket
(require lang/htdp-intermediate)

;; g-fives-closed : N -> N
(define (g-fives-sequence n)
  (* 3 (expt 5 n)))

;; seq-g-fives : N -> (listof N)
;; Creates a sequence of a-fives-closed s
(define (seq-g-fives n)
  (build-list n g-fives-sequence))

;; TESTS
(equal? (seq-g-fives 5) (list 3 15 75 375 1875))
