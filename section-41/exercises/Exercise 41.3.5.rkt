#lang racket
(require lang/htdp-advanced)

(define SPADES 'spades)
(define HEARTS 'hearts)
(define DIAMDONS 'diamonds)
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
             [else (error 'managed-hand "message not understood")])))
    service-manager))

;; TESTS

(define a-hand empty)

(define (reset-hand)
  (begin (set! a-hand (create-hand 13 SPADES))
         ((a-hand 'insert!) 10 HEARTS)
         ((a-hand 'insert!) 5 CLUBS)
         ((a-hand 'insert!) 5 HEARTS)))

(reset-hand)
((a-hand 'remove) 10)
((a-hand 'status) (make-hand 13 SPADES (make-hand 5 HEARTS (make-hand 5 CLUBS empty))))

(reset-hand)
((a-hand 'remove) 5)
((a-hand 'status) (make-hand 13 SPADES (make-hand 10 HEARTS (make-hand 5 CLUBS empty))))

(reset-hand)
((a-hand 'remove) 13)
((a-hand 'status) (make-hand 10 HEARTS (make-hand 5 HEARTS (make-hand 5 CLUBS empty))))
