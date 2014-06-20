;; contains-doll-2? : list-of-symbols  ->  boolean
;; to determine whether the symbol 'doll occurs on a-list-of-symbols
(define (contains-doll-2? a-list-of-symbols)
  (cond
    [(empty? a-list-of-symbols) false]
    [else (or (symbol=? (first a-list-of-symbols) 'doll)
           (contains-doll-2? (rest a-list-of-symbols)))]))

;; TEST
(boolean=? (contains-doll-2? empty) false)
(boolean=? (contains-doll-2? (cons 'ball empty)) false)
(boolean=? (contains-doll-2? (cons 'arrow (cons 'doll empty))) true)
(boolean=? (contains-doll-2? (cons 'bow (cons 'arrow (cons 'ball empty)))) false)


