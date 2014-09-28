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

;; SUITS:
(define SPADES 'spades)
(define HEARTS 'hearts)
(define DIAMONDS 'diamonds)
(define CLUBS 'clubs)

;; hand : symbol -> service-manager
(define (create-hand rank suit)
  (local (
          ;; hand : (listof (listof number symbol))
          ;; Keeps track of the hand
          (define current-hand (list (list rank suit)))

    ;; add-at-end! : rank suit  ->  void
    ;; effect: to add a card with v as rank and
    ;; s as suit at the end of current-hand
    (define (add-at-end! rank suit)
      (set! current-hand (append current-hand (list (list rank suit)))))

    ;; last-card : hand -> (listof number symbol)
    ;; Finds the last card from the given hand
    (define (last-card) (last current-hand))

    (define (service-manager msg)
      (cond
       [(symbol=? msg 'add) add-at-end!]
       [(symbol=? msg 'last) (last-card)]
       [else (error 'hand "Unknown message")])))
  service-manager))

;; TESTS
(define test-hand (create-hand 9 CLUBS))
((test-hand 'add) 2 CLUBS)
(equal? (test-hand 'last) (list 2 CLUBS))
