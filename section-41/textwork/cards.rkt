#|
Simulating a Card Game

A rank is a number between 1 and 13.

A hand is either
* (make-hand rank suit empty)
* (make-hand rank suit next)
where next is a hand.
|#
(define-struct hand (rank suit next))

;; SUITS:

(define SPADES 'spades)
(define HEARTS 'hearts)
(define DIAMONDS 'diamonds)
(define CLUBS 'clubs)

;; create-hand : rank suit -> hand
;; to create a single-card hand from r and s
(define (create-hand r s) (makehand r s empty))

;; add-at-end! : rank suit hand  ->  void
;; effect: to add a card with v as rank and s as suit at the end of a-hand
(define (add-at-end! rank suit a-hand)
  (cond
    [(empty? (hand-next a-hand))
     (set-hand-next! a-hand  (make-hand rank suit empty))]
    [else (add-at-end! rank suit (hand-next a-hand))]))
