;; contains-doll? : list-of-symbols  ->  boolean
;; to determine whether the symbol 'doll occurs on a-list-of-symbols
(define (contains-doll? a-list-of-symbols)
  (cond
    [(empty? a-list-of-symbols) false]
    [else (cond
            [(symbol=? (first a-list-of-symbols) 'doll) true]
            [else (contains-doll? (rest a-list-of-symbols))])]))

;; TEST
(boolean=? (contains-doll? empty) false)
(boolean=? (contains-doll? (cons 'ball empty)) false)
(boolean=? (contains-doll? (cons 'doll empty)) true)
(boolean=? (contains-doll? (cons 'bow (cons 'ax (cons 'ball empty)))) false)
(boolean=? (contains-doll? (cons 'arrow (cons 'doll (cons 'ball empty)))) true)
