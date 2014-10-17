#lang racket
(require lang/htdp-advanced)

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
(define (create-hand r s) (make-hand r s empty))

;; add-at-end! : rank suit hand  ->  void
;; effect: to add a card with v as rank and s as suit at the end of a-hand
(define (add-at-end! rank suit a-hand)
  (cond
    [(empty? (hand-next a-hand))
     (set-hand-next! a-hand (make-hand rank suit empty))]
    [else (add-at-end! rank suit (hand-next a-hand))]))

;; last-card : hand -> (listof number symbol)
;; Finds the last card from the given hand
(define (last-card a-hand)
  (cond
   [(empty? (hand-next a-hand)) (list (hand-rank a-hand)
                                      (hand-suit a-hand))]
   [else (last-card (hand-next a-hand))]))

;; TESTS
(define test-hand (create-hand 9 CLUBS))
(add-at-end! 4 HEARTS test-hand)
(equal? (last-card test-hand) (list 4 HEARTS))
