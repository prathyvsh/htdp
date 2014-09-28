;; A hand is an interface:
;; 'insert :: rank suit  ->  void

;; create-hand : rank suit  ->  hand
;; to create a hand from the rank and suit of a single card
(define (create-hand rank suit)
  (local ((define-struct hand (rank suit next))
	  
          (define the-hand (make-hand rank suit empty))
	  
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
	  
          (define (service-manager msg)
            (cond
              [(symbol=? msg 'insert!) 
               (lambda (r s)
                 (cond
                   [(> r (hand-rank the-hand))
                    (set! the-hand (make-hand r s the-hand))]
                   [else (insert-aux! r s the-hand)]))]
              [else (error 'managed-hand "message not understood")])))
    service-manager))
