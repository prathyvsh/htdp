#lang racket
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
    ...
    ))

;; the number of words we can choose from 
(define WORDS# (length WORDS))

;; chosen-word : word
;; the word that the player is to guess
(define chosen-word (first WORDS))

;; status-word : word
;; represents which letters the player has and hasn't guessed
(define status-word (first WORDS))

;; body-parts-left : (listof body-part)
;; represents the list of body parts that are still "available"
(define body-parts-left PARTS)

;; hangman :  ->  void
;; effect: initialize chosen-word, status-word, and body-parts-left
(define (hangman)
  (begin
    (set! chosen-word (list-ref WORDS (random (length WORDS))))
    (set! status-word (build-list (length chosen-word) (lambda (x) '_)))
    (set! body-parts-left PARTS)))

;; hangman-guess : letter  ->  response
;; to determine whether the player has won, lost, or may continue to play
;; and, if so, which body part was lost, if no progress was made
;; effects: (1) if the guess represents progress, update status-word
;; (2) if not, shorten the body-parts-left by one 
(define (hangman-guess guess)
  (local ((define new-status (reveal-list chosen-word status-word guess)))
    (cond
      [(equal? new-status status-word)
       (local ((define next-part (first body-parts-left)))
         (begin 
           (set! body-parts-left (rest body-parts-left))
           (cond
             [(empty? body-parts-left) (list "The End" chosen-word)]
             [else (list "Sorry" next-part status-word)])))]
      [else
       (cond
         [(equal? new-status chosen-word) "You won"]
         [else 
          (begin 
            (set! status-word new-status)
            (list "Good guess!" status-word))])])))

;; reveal-list : word word letter  ->  word
;; to compute the new status word
(define (reveal-list chosen-word status-word guess)
  (local ((define (reveal-one chosen-letter status-letter)
	    (cond
	      [(symbol=? chosen-letter guess) guess]
	      [else status-letter])))
    (map reveal-one chosen-word status-word)))

;; TESTS
(set! chosen-word '(b a l l))
(set! status-word '(b _ _ _))
(equal? (hangman-guess 'l) (list "Good guess!" '(b _ l l)))

(set! chosen-word '(b a l l))
(set! status-word '(b _ l l))
(equal? (hangman-guess 'a) "You won")

(set! chosen-word '(b a l l))
(set! status-word '(b _ l l))
(set! body-parts-left (list 'right-leg 'left-leg))
(equal? (hangman-guess 'l) (list "Sorry" 'right-leg '(b _ l l)))

(set! chosen-word '(b a l l))
(set! status-word '(b _ l l))
(set! body-parts-left (list 'left-leg))
(and (equal? (hangman-guess 'l) (list "The End" '(b a l l)))
     (equal? body-parts-left empty))

(set! chosen-word '(t r a m p o l i n e))
(set! status-word '(t _ _ _ _ _ _ _ _ _))
(equal? (hangman-guess 'l) (list "Good guess!" '(t _ _ _ _ _ l _ _ _)))

(set! chosen-word '(t r a m p o l i n e))
(set! status-word '(t r a m p o l i n _))
(equal? (hangman-guess 'e) "You won")

(set! chosen-word '(t r a m p o l i n e))
(set! status-word '(t r a m p o l i n _))
(set! body-parts-left (list 'left-arm 'right-leg 'left-leg))
(equal? (hangman-guess 'y) (list "Sorry" 'left-arm '(t r a m p o l i n _)))

(set! chosen-word '(t r a m p o l i n e))
(set! status-word '(t r a m p o l i n _))
(set! body-parts-left (list 'left-leg))
(and (equal? (hangman-guess 'l) (list "The End" '(t r a m p o l i n e)))
     (equal? body-parts-left empty))
