#lang racket
(require lang/htdp-beginner)

;; check-color : symbol symbol symbol symbol -> symbol
(define (check-color target1 target2 guess1 guess2)
  (cond
  [(exact-match target1 target2 guess1 guess2) 'Perfect]
  [(correct-position-guess target1 target2 guess1 guess2) 'OneColorAtCorrectPosition]
  [(correct-color-guess target1 target2 guess1 guess2) 'OneColorOccurs]
  [else 'NothingCorrect]
  ))

;; exact-match : symbol symbol symbol symbol -> boolean
;; When both the guess match exact color and location
(define (exact-match t1 t2 g1 g2)
  (and (symbol=? t1 g1) (symbol=? t2 g2)))

;; correct-position-guess : symbol symbol symbol symbol -> boolean
;; When the guesses match the exact color in the exact location in one
;; of the places
(define (correct-position-guess t1 t2 g1 g2)
  (or (symbol=? t1 g1) (symbol=? t2 g2)))

;; correct-color-guess : symbol symbol symbol symbol -> boolean
;; If a correct color was guessed but not at the right position
(define (correct-color-guess t1 t2 g1 g2)
  (or (symbol=? t1 g2) (symbol=? t2 g1)))

;; TESTS
(symbol=? (check-color 'red 'red 'red 'red) 'Perfect)
(symbol=? (check-color 'blue 'red 'red 'red) 'OneColorAtCorrectPosition)
(symbol=? (check-color 'blue 'red 'orange 'red) 'OneColorAtCorrectPosition)
(symbol=? (check-color 'blue 'red 'red 'green) 'OneColorOccurs)
(symbol=? (check-color 'blue 'red 'mango 'banana) 'NothingCorrect)

