;; last-occurrence : symbol list-of-star -> star or false
;; to find the last star record in alostars that contains s in name field
(define (last-occurrence s alostars)
  (cond
   [(empty? alostars) false]
   [else (local ((define r (last-occurrence s (rest alostars))))
           (cond
            [(star? r) r]
            [(symbol=? (star-name (first alostars)) s) (first alostars)] [else false]))]))
