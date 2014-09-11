;; Constants:
;; the legitimate colors
(define COLORS (list 'black 'white 'red 'blue 'green 'gold 'pink 'orange 'purple 'navy))

;; the number of colors
(define COL# (length COLORS))

;; Data Definition:
;; A color is a symbol on COLORS.

;; target1, target2 : color
;; the two variables represent the two colors that the first player chose

(define target1 (first COLORS)) (define target2 (first COLORS))

;; master : -> void
;; effect: set target1 and target2 to two randomly chosen items from COLORS
(define (master)
  (begin (set! target1
               (list-ref COLORS (random COL#))) (set! target2 (list-ref COLORS (random COL#)))))

;; master-check : color color -> symbol
;; to determine how many colors at how many positions are guessed correctly
;; The function defers to check-color, the solution of exercise 5.1.5.
(define (master-check guess1 guess2)
  (check-color guess1 guess2 target1 target2))

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

