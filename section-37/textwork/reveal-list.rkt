;; reveal-list : word word letter  ->  word
;; to compute the new status word
;; effect: to set new-knowledge to true if guess reveals new knowledge
(define (reveal-list chosen-word status-word guess)
  (local ((define (reveal-one chosen-letter status-letter)
	    (cond
	      [(and (symbol=? chosen-letter guess)
		    (symbol=? status-letter '_))
	       (begin
		 (set! new-knowledge true)
		 guess)]
	      [else status-letter])))
    (begin
      (set! new-knowledge false)
      (map reveal-one chosen-word status-word))))
