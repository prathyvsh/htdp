;; how-many : list-of-symbols -> number
;; to determine how many symbols are on a-list-of-symbols
(define (how-many a-list-of-symbols)
  (cond
    [(empty? a-list-of-symbols) 0]
    [else (+ 1 (how-many (rest a-list-of-symbols)))]))
