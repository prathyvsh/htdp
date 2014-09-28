#lang racket
(require lang/htdp-advanced)

(define-struct hand (rank suit next))
(define SPADES 'spades)
(define HEARTS 'hearts)
(define DIAMONDS 'diamonds)
(define CLUBS 'clubs)

;; create-hand : rank suit  ->  hand
;; to create a hand from the rank and suit of a single card
(define (create-hand rank suit)
  (local ((define the-hand (make-hand rank suit empty))

          ;; sorted-insert : rank suit -> void
          ;; Effect : Inserts the given card in a sorted order
          (define (sorted-insert r s)
            (set! the-hand (insert-card r s the-hand)))
	  
          ;; insert : rank suit hand  ->  hand
          ;; ASSUMPTION: hand is sorted by rank in descending order
          ;; inserts the given card into a list of hands in the sorted order
          (define (insert-card r s a-hand)
            (cond
             [(> r (hand-rank a-hand)) (make-hand r s a-hand)]
             [else (local ((define (insert-aux remaining-hand)
                             (cond
                              [(empty? remaining-hand) (make-hand r s empty)]
                              [else
                               (local ((define facing-card-rank (hand-rank remaining-hand))
                                       (define facing-card-suit (hand-suit remaining-hand)))
                                 
                                 (cond
                                  [(>= r facing-card-rank) (make-hand r s remaining-hand)]
                                  [else (make-hand facing-card-rank facing-card-suit
                                                   (insert-aux (hand-next remaining-hand)))]))])))
                     (insert-aux a-hand))]))
          
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'insert) sorted-insert]
             [(symbol=? msg 'status) the-hand]
             [else (error 'managed-hand "message not understood")])))
    service-manager))

;; TESTS
(define a-hand (create-hand 3 SPADES))
((a-hand 'insert) 10 HEARTS)
((a-hand 'insert) 5 HEARTS)
((a-hand 'insert) 5 CLUBS)
((a-hand 'insert) 2 CLUBS)
((a-hand 'insert) 4 DIAMONDS)
((a-hand 'insert) 7 CLUBS)
(equal? (a-hand 'status)
        (make-hand 10 HEARTS
                   (make-hand 7 CLUBS
                              (make-hand 5 CLUBS
                                         (make-hand 5 HEARTS
                                                    (make-hand 4 DIAMONDS
                                                               (make-hand 3 SPADES
                                                                          (make-hand 2 CLUBS empty))))))))
