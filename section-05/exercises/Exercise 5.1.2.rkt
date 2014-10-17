#lang racket
(require lang/htdp-beginner)

;; check-guess : number number -> symbol
;; Checks the relationship between a guess and a target
(define (check-guess guess target)
  (cond
    [(< guess target) 'TooSmall]
    [(> guess target) 'TooLarge]
    [(= guess target) 'Perfect]))

;; TESTS
(symbol=? (check-guess 10 20) 'TooSmall)
(symbol=? (check-guess 20 20) 'Perfect)
(symbol=? (check-guess 20 10) 'TooLarge)
