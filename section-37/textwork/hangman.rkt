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
    (set! status-word ...)
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
