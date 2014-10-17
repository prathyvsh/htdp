#lang racket
(require lang/htdp-advanced)

(define SPADES 'spades)
(define HEARTS 'hearts)
(define DIAMONDS 'diamonds)
(define CLUBS 'clubs)

;; A hand is an interface:
;; 'insert :: rank suit  ->  void
(define-struct hand (rank suit next))

;; create-hand : rank suit  ->  hand
;; to create a hand from the rank and suit of a single card
(define (create-hand rank suit)
  (local ((define the-hand (make-hand rank suit empty))
	  
          ;; insert-aux! : rank suit hand  ->  void
          ;; assume: hand is sorted by rank in descending order
          ;; effect: to add a card with r as rank and s as suit
          ;; at the proper place
          (define (insert-aux! r s a-hand)
            (cond
             [(empty? (hand-next a-hand)) 
              (set-hand-next! a-hand (make-hand r s empty))]
             [else (cond
                    [(>= (hand-rank a-hand)
                         r
                         (hand-rank (hand-next a-hand)))
                     (set-hand-next! a-hand
                                     (make-hand r s (hand-next a-hand)))]
                    [else (insert-aux! r s (hand-next a-hand))])]))

          ;; remove : rank -> void
          ;; Effect: Remove first card of a given rank, even if it is the only card
          (define (remove rank)
            (cond
             [(= rank (hand-rank the-hand))
              (set! the-hand (hand-next the-hand))]
             [else 
              (local ((define (remove-aux previous hand)
                        (cond
                         [(= rank (hand-rank hand)) (set-hand-next! previous (hand-next hand))]
                         [else (remove-aux hand (hand-next hand))])))
                (remove-aux empty the-hand))]))

          ;; suits-with-rank : number -> (listof symbol)
          ;; Finds all the suits with the given rank
          (define (suits-with-rank rank)
            (local (
                    (define (collect-suits hand acc)
                      (cond
                       [(empty? hand) acc]
                       [(= rank (hand-rank hand)) (collect-suits (hand-next hand) (cons (hand-suit hand) acc))]
                        [else (collect-suits (hand-next hand) acc)])))
                    (collect-suits the-hand empty)))

          ;; status-equal? : hand -> boolean
          ;; Checks if the status of hand is equal to the given list
          (define (status-equal? st) (equal? st the-hand))
	  
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'insert!)
              (lambda (r s)
                (cond
                 [(> r (hand-rank the-hand))
                  (set! the-hand (make-hand r s the-hand))]
                 [else (insert-aux! r s the-hand)]))]
             [(symbol=? msg 'remove) remove]
             [(symbol=? msg 'status) status-equal?]
             [(symbol=? msg 'suits) suits-with-rank]
             [else (error 'managed-hand "message not understood")])))
    service-manager))

;; TESTS

(define a-hand (create-hand 13 SPADES))
((a-hand 'insert!) 13 HEARTS)
((a-hand 'insert!) 5 SPADES)
((a-hand 'insert!) 5 DIAMONDS)
((a-hand 'insert!) 2 CLUBS)
((a-hand 'insert!) 1 HEARTS)
((a-hand 'insert!) 1 SPADES)
((a-hand 'insert!) 1 CLUBS)
((a-hand 'insert!) 1 DIAMONDS)

(equal? ((a-hand 'suits) 13) (list HEARTS SPADES))
(equal? ((a-hand 'suits) 5) (list SPADES DIAMONDS))
(equal? ((a-hand 'suits) 2) (list CLUBS))
(equal? ((a-hand 'suits) 1) (list HEARTS SPADES CLUBS DIAMONDS))
  
  
  
