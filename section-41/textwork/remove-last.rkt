;; remove-last! : hand  ->  void
;; effect : to remove the last card in a-hand0, unless it is the only one
(define (remove-last! a-hand0)
  (local (;; predecessor-of:a-hand represents the predecessor of
	  ;; a-hand in the a-hand0 chain 
	  (define (rem! a-hand predecessor-of:a-hand)
	    (cond
             [(empty? (hand-next a-hand))
              (set-hand-next! predecessor-of:a-hand empty)]
             [else (rem! (hand-next a-hand) a-hand)])))
    (cond
     [(empty? (hand-next a-hand0)) (void)]
     [else (rem! (hand-next a-hand0) a-hand0)])))
Both applications of rem! have the shape

(rem! (hand-next a-hand) a-hand)
