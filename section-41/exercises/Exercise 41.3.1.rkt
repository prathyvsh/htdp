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
     (set-hand-next! a-hand  (make-hand rank suit empty))]
    [else (add-at-end! rank suit (hand-next a-hand))]))

(define hand0 (create-hand 13 SPADES))

(begin
  (add-at-end! 1 DIAMONDS hand0)
  (add-at-end! 2 CLUBS hand0)
  hand0)

;; EVALUATIONS

(define hand0 (make-hand 13 SPADES empty))
(begin (cond
    [(empty? (hand-next hand0))
     (set-hand-next! hand0  (make-hand 1 DIAMONDS empty))]
    [else (add-at-end! 1 DIAMONDS (hand-next hand0))])
  (add-at-end! 2 CLUBS hand0) hand0)

;;

(define hand0 (make-hand 13 SPADES empty))
(begin (cond
    [(empty? (hand-next hand0))
     (set-hand-next! hand0  (make-hand 1 DIAMONDS empty))]
    [else (add-at-end! 1 DIAMONDS (hand-next hand0))])
  (add-at-end! 2 CLUBS hand0) hand0)

;;

(define hand0 (make-hand 13 SPADES empty))
(begin (cond
        [(empty? (hand-next hand0 empty))
         (set-hand-next! hand0 (make-hand 1 DIAMONDS empty))]
        [else (add-at-end! 13 SPADES (hand-next hand0))])
       (add-at-end! 2 CLUBS hand0) hand0)

;;

(define hand0 (make-hand 13 SPADES empty))
(begin (cond
        [(empty? empty)
         (set-hand-next! hand0 (make-hand 1 DIAMONDS empty))]
        [else (add-at-end! 13 SPADES (hand-next hand0))])
       (add-at-end! 2 CLUBS hand0) hand0)

;;

(define hand0 (make-hand 13 SPADES empty))
(begin (cond
        [(empty? empty) (set-hand-next! hand0 (make-hand 1 DIAMONDS empty))]
        [else (add-at-end! 13 SPADES (hand-next hand0))])
       (add-at-end! 2 CLUBS hand0) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void)
       (add-at-end! 2 CLUBS hand0) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void) (cond
        [(empty? (hand-next hand0 empty))
         (set-hand-next! hand0 (make-hand 2 CLUBS empty))]
        [else (add-at-end! 13 SPADES (hand-next hand0))]) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void) (cond
        [(empty? (hand-next (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)) empty))
         (set-hand-next! hand0 (make-hand 2 CLUBS empty))]
        [else (add-at-end! 13 SPADES (hand-next hand0))]) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void) (cond
        [(empty? (make-hand 1 DIAMONDS empty))
         (set-hand-next! hand0 (make-hand 2 CLUBS empty))]
        [else (add-at-end! 13 SPADES (hand-next hand0))]) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void) (cond
        [false
         (set-hand-next! hand0 (make-hand 2 CLUBS empty))]
        [else (add-at-end! 13 SPADES (hand-next (make-hand 13 SPADES (make-hand 1 DIAMONDS empty))))]) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void) (add-at-end! 1 DIAMONDS (make-hand 1 DIAMONDS empty)) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void) (cond
        [(empty? (hand-next (make-hand 1 DIAMONDS empty)))
         (set-hand-next! (make-hand 1 DIAMONDS empty) (make-hand 2 CLUBS empty))]
        [else (add-at-end! 1 DIAMONDS (hand-next (make-hand 1 DIAMONDS)))]) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS empty)))
(begin (void) (set-hand-next! (make-hand 1 DIAMONDS empty) (make-hand 2 CLUBS empty)) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS (make-hand 2 CLUBS empty))))
(begin (void) (void) hand0)

;;

(define hand0 (make-hand 13 SPADES (make-hand 1 DIAMONDS (make-hand 2 CLUBS empty))))
hand0

;;

(make-hand 13 SPADES (make-hand 1 DIAMONDS (make-hand 2 CLUBS empty)))
