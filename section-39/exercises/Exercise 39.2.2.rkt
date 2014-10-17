#lang racket
(require htdp/gui)
(require lang/htdp-advanced)

(define COLORS (list 'black 'white 'red 'blue 'green 'gold 'pink 'orange 'purple 'navy))

(define (make-master)
  (local (
;; Constants:
;; the legitimate colors

;; the number of colors
(define COL# (length COLORS))

;; Data Definition:
;; A color is a symbol on COLORS.

;; target1, target2 : color
;; the two variables represent the two colors that the first player chose

(define target1 (first COLORS))
(define target2 (first COLORS))

;; guess-count : number
;; Keeps track of the number of guesses made by the player.

(define guess-count 0)


;; master : -> void
;; effect: set target1 and target2 to two randomly chosen items from COLORS
(define (init)
  (begin (set! target1 (random-pick COLORS))
         (set! target2 (random-pick COLORS))
         (set! guess-count 0)))

;; master-check : color color -> symbol
;; to determine how many colors at how many positions are guessed correctly
;; The function defers to check-color, the solution of exercise 5.1.5.
(define (check guess1 guess2)
  (begin (set! guess-count (add1 guess-count))
         (local ((define result (check-color guess1 guess2 target1 target2)))
           (cond
            [(symbol=? result 'Perfect) (begin (init) (list result guess-count))]
            [else result]))))

;; check-color : symbol symbol symbol symbol -> symbol/(listof symbol)
;; Checks colors and returns the result
(define (check-color target1 target2 guess1 guess2)
  (cond
   [(exact-match target1 target2 guess1 guess2) 'Perfect]
   [(correct-position-guess target1 target2 guess1 guess2) 'OneColorAtCorrectPosition]
   [(correct-color-guess target1 target2 guess1 guess2) 'OneColorOccurs]
   [else 'NothingCorrect]))

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


;; random-pick : (listof symbol) -> symbol
;; Chooses a random symbol from the given list.
(define (random-pick lst)
  (list-ref lst (random COL#)))

;; service-manager : symbol -> void
(define (service-manager msg)
  (cond
   [(symbol=? msg 'check) check]
   [(symbol=? msg 'guess) guess-count]
   [(symbol=? msg 'reveal) (string-append "The colors where " (symbol->string target1) " and " (symbol->string target2))]
   [(symbol=? msg 'reset) (init)]
   [else (error 'service-manager "Unknown message")])))
 (begin (init) service-manager)))


;; create-buttons : (listof symbol) -> (listof button)
;; Creates a list of buttons from the given list of symbols
(define (create-buttons lst)
  (map (lambda (x) (make-button (symbol->string x) (lambda (e) (check-choice x)))) lst))

;; chosen-colors : (listof symbol)
;; Keeps track of the colors picked by the user
(define chosen-colors empty)

(define master1 (make-master))

(define (guess-count) (master1 'guess))

;; check-choice : symbol
;; Checks the choices given by the player
(define (check-choice x)
  (begin (set! chosen-colors (cons x chosen-colors))
         (cond
          [(= (length chosen-colors) 1) (update-labels color1-label x "Choose another")]
          [else (begin
                  ;; Passing second-color because chosen-colors is cons-ed  in the reverse order
                  (local ((define result ((master1 'check) (second chosen-colors) (first chosen-colors))))
                          
                    (cond
                     [(cons? result) (update-labels color2-label x "You won")]
                     [else (update-labels color2-label x (symbol->string result))]))
                  (set! chosen-colors empty)
                  (draw-message guess-label (number->string (guess-count))))])))

(define (update-labels label sym str)
  (and (draw-message label (symbol->string sym))
       (draw-message help-label str)))

(define (give-up e)
  (begin (draw-message help-label (master1 'reveal)) (master1 'reset) true))

(define color1-label (make-message "First color"))
(define color2-label (make-message "Second color"))
(define help-label (make-message "Pick a color to start"))
(define guess-label (make-message (number->string (guess-count))))
(define give-up-button (make-button "Give up" give-up))



;; Initializer
(create-window (list (create-buttons COLORS)
                     (list help-label guess-label color1-label color2-label)
                     (list give-up-button)))
