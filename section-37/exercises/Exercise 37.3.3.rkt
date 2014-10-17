#lang racket
(require htdp/gui)
(require htdp/draw)
(require lang/htdp-advanced)

;; Data Analysis and Definitions:

;; A letter is a symbol in: 'a ... 'z plus '_

;; A word is a (listof letter).

;; A body-part is one of the following symbols:
(define PARTS '(head body right-arm left-arm right-leg left-leg))

;; Constants:
;; some guessing words: 
(define WORDS 
  '((h e l l o)
    (w o r l d)
    (i s)
    (a)
    (s t u p i d)
    (p r o g r a m)
    (a n d)
    (s h o u l d)
    (n e v e r)
    (b e)
    (u s e d)
    (o k a y)
    ))

;; the number of words we can choose from 
(define WORDS# (length WORDS))

;; new-knowledge : boolean
;; the variable represents whether the most recent application of
;; reveal-list has provided the player with new knowledge
(define new-knowledge false)

;; chosen-word : word
;; the word that the player is to guess
(define chosen-word (first WORDS))

;; status-word : word
;; represents which letters the player has and hasn't guessed
(define status-word (first WORDS))

;; body-parts-left : (listof body-part)
;; represents the list of body parts that are still "available"
(define body-parts-left PARTS)

;; guesses-so-far : (listof symbol)
;; keeps track of all the guesses made by a user in a session.
(define guesses-so-far empty)

;; hangman :  ->  void
;; effect: initialize chosen-word, status-word, and body-parts-left
(define (hangman)
  (begin
    (set! chosen-word (list-ref WORDS (random (length WORDS))))
    (set! status-word (build-list (length chosen-word) (lambda (x) '_)))
    (set! body-parts-left PARTS)
    (set! new-knowledge false)
    (draw-next-part 'noose)))

;; hangman-guess : letter  ->  response
;; to determine whether the player has won, lost, or may continue to play
;; and, if so, which body part was lost, if no progress was made
;; effects: (1) if the guess represents progress, update status-word
;; (2) if not, shorten the body-parts-left by one 
(define (hangman-guess guess)
  (begin (set! status-word (reveal-list chosen-word status-word guess))
    (cond
     [(not new-knowledge)
      (local ((define next-part (first body-parts-left)))
        (begin 
          (set! body-parts-left (rest body-parts-left))
          (cond
           [(empty? body-parts-left) (list "The End" next-part chosen-word)]
           [else (list "Sorry" next-part status-word)])))]
     [else
      (cond
       [(equal? status-word chosen-word) "You won"]
       [else (list "Good guess!" status-word)])])))

;; reveal-list : word word letter  ->  word
;; to compute the new status word
;; effect: to set new-knowledge to true if guess reveals new knowledge
(define (reveal-list chosen-word status-word guess)
  (local ((define (reveal-one chosen-letter status-letter)
	    (cond
	      [(and (symbol=? chosen-letter guess)
		    (symbol=? status-letter '_))
	       (begin
		 (set! new-knowledge true)
		 guess)]
	      [else status-letter])))
    (begin
      (set! new-knowledge false)
      (map reveal-one chosen-word status-word))))

;; DRAWING FUNCTIONS
;; =================

(define TOP-OFFSET 10)
(define PLANK-HORIZONTAL-WIDTH 100)
(define NOOSE-VERTICAL-HEIGHT 30)
(define HEAD-RADIUS 10)
(define BODY-HEIGHT 50)
(define ARM-LENGTH 60)
(define ARM-SLANT 10)
(define LEG-SLANT 30)

(define plank-start (make-posn 0 TOP-OFFSET))
(define plank-end (make-posn (+ (posn-x plank-start) PLANK-HORIZONTAL-WIDTH) (posn-y plank-start)))
(define head-location (make-posn (posn-x plank-end) (+ (posn-y plank-end) NOOSE-VERTICAL-HEIGHT HEAD-RADIUS)))
(define body-start (make-posn (posn-x head-location) (+ (posn-y head-location) HEAD-RADIUS)))
(define body-end (make-posn (posn-x body-start) (+ (posn-y body-start) BODY-HEIGHT)))
(define arm-start (make-posn PLANK-HORIZONTAL-WIDTH (+ NOOSE-VERTICAL-HEIGHT HEAD-RADIUS (* 2/3 BODY-HEIGHT))))
(define left-arm-end (make-posn (+ ARM-LENGTH (posn-x arm-start)) (- (posn-y arm-start) ARM-SLANT)))
(define right-arm-end (make-posn (- (posn-x arm-start) ARM-LENGTH) (posn-y left-arm-end)))
(define leg-start (make-posn PLANK-HORIZONTAL-WIDTH (+ TOP-OFFSET NOOSE-VERTICAL-HEIGHT (* 2 HEAD-RADIUS) BODY-HEIGHT)))
(define left-leg-end (make-posn (+ ARM-LENGTH (posn-x arm-start)) (+ (posn-y leg-start) LEG-SLANT)))
(define right-leg-end (make-posn (- (posn-x arm-start) ARM-LENGTH) (posn-y left-leg-end)))

;; AUXILARY FUNCTIONS
;; circle is a structure
;; make-circle position number symbol
(define-struct circle (center radius color))

;; draw-a-circle : circle -> true
;; Draws a give circle on screen
(define (draw-a-circle c)
  (draw-circle (circle-center c) (circle-radius c) (circle-color c)))

;; draw-plank : position position -> true
;; Draws a horizontal plank from start to end
(define (draw-plank start end)
  (draw-solid-line start end 'black))
;; draw-noose : position position -> true
;; Draws a noose from start to end
(define (draw-noose start end)
  (and (draw-plank start end)
       (draw-solid-line end (make-posn (posn-x end) (+ (posn-y start) NOOSE-VERTICAL-HEIGHT)) 'black)))

;; draw-head : position -> true
;; Draws a circular head at the given location
(define (draw-head location)
  (draw-a-circle (make-circle location HEAD-RADIUS 'black)))

;; draw-body : position position -> true
;; Draws body from start to end
(define (draw-body start end)
  (draw-solid-line start end 'black))

;; draw-limb : position position -> true
;; Draws a limb from start to end
(define (draw-limb start end) 
  (draw-solid-line start end 'black))

;; draw-next-part : symbol -> true
;; Takes in a symbol and draws the corresponding part
(define (draw-next-part organ) 
  (cond
   [(symbol=? organ 'noose) (draw-noose plank-start plank-end)]
   [(symbol=? organ 'head) (draw-head head-location)]
   [(symbol=? organ 'body) (draw-body body-start body-end)]
   [(symbol=? organ 'left-arm) (draw-limb arm-start left-arm-end)]
   [(symbol=? organ 'right-arm) (draw-limb arm-start right-arm-end)]
   [(symbol=? organ 'left-leg) (draw-limb leg-start left-leg-end)]
   [(symbol=? organ 'right-leg) (draw-limb leg-start right-leg-end)]
   ))

;; los->string : (listof symbol) -> string
;; Converts a list of symbol to string
(define (los->string lst)
  (foldr string-append "" (map symbol->string lst)))

(begin (set! status-word (list 'b '_ 'l 'l)) (set! chosen-word (list 'b 'a 'l 'l))
(and (equal? (reveal-list chosen-word status-word 'a) (list 'b 'a 'l 'l))
     (equal? new-knowledge true)))

(begin (set! status-word (list 'b '_ '_ '_)) (set! chosen-word (list 'b 'a 'l 'l))
(and (equal? (reveal-list chosen-word status-word 'x) (list 'b '_ '_ '_))
     (equal? new-knowledge false)))

(begin (set! status-word (list 'b '_ '_ '_))
(set! chosen-word (list 'b 'a 'l 'l))
(and (equal? (reveal-list chosen-word status-word 'l) (list 'b '_ 'l 'l))
     (equal? new-knowledge true)))

(begin (set! status-word (list 'b '_ 'l 'l))
(set! chosen-word (list 'b 'a 'l 'l))
(and (equal? (reveal-list chosen-word status-word 'l) (list 'b '_ 'l 'l))
     (equal? new-knowledge false)))

;; check-choice : event -> true
;; Checks the currently made choice in the GUI and
;; performs appropriate action.
(define (check-choice e)
  (cond
    [(or (empty? body-parts-left)
         (equal? chosen-word status-word)) true]
    [else 
  (local ((define current-choice (list-ref ALPHABETS (choice-index guess-maker))))
    (cond
     [(memq current-choice guesses-so-far) (draw-message help-label "You have made that guess before")]
     [else (local ((define result (hangman-guess (string->symbol current-choice)))) (begin (set! guesses-so-far (cons current-choice guesses-so-far))
                  (cond
                   [(cons? result) (and (draw-message help-label (first result))
                                        (cond
                                         [(equal? "Sorry" (first result)) (and (draw-next-part (second result))
                                                                               (draw-message status-string (los->string (third result))))]
                                         [(equal? "You won" (first result)) true]
                                         [(equal? "The End" (first result)) (and (draw-next-part (second result))
                                                                                 (draw-message status-string (los->string (third result))))]
                                         [else (draw-message status-string (los->string (second result)))]))]
                   [else (and (draw-message help-label result)
                              (draw-message status-string (los->string chosen-word)))])))]))]))

    (start 300 300)
    (hangman)
    (define ALPHABETS (map symbol->string '(a b c d e f g h i j k l m n o p q r s t u v w x y z)))
    (define guess-maker (make-choice ALPHABETS))
    (define help-label (make-message "Pick an alphabet"))
    (define status-string (make-message (los->string status-word)))
    (create-window (list (list status-string) (list help-label guess-maker (make-button "Check" check-choice))))
