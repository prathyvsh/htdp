#lang racket
(require lang/htdp-beginner)

;; check-guess3 number number number number -> symbol
;; Checks the relationship between digits inputted and the guess
(define (check-guess3 d1 d2 d3 target)
  (check-guess (convert3 d1 d2 d3) target))

;; check-guess : number number -> symbol
;; Checks the relationship between a guess and a target
(define (check-guess guess target)
  (cond
    [(< guess target) 'TooSmall]
    [(> guess target) 'TooLarge]
    [(= guess target) 'Perfect]))

;;Convert3 : number number number -> number
;;Builds three digit number from it's digits
;;[Note to self] Better generalized recursion implementation possible.
(define (convert3 d1 d2 d3)
  (+ d1 (+ (* d2 10) (* d3 100))))

;; TESTS
(symbol=? (check-guess3 1 2 3 321) 'Perfect)
(symbol=? (check-guess3 3 2 1 123) 'Perfect)
(symbol=? (check-guess3 1 2 3 400) 'TooSmall)
(symbol=? (check-guess3 4 2 3 400) 'TooSmall)
(symbol=? (check-guess3 4 2 8 400) 'TooLarge)
(symbol=? (check-guess3 4 9 8 400) 'TooLarge)

