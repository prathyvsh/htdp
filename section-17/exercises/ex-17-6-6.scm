;; DNAprefix : list-of-symbols list-of-symbols -> boolean
;; Determines if pattern is a prefix of search-string
(define (DNAprefix pattern search-string)
  (cond
[(and (empty? pattern) (empty? search-string)) true]
[(empty? search-string) false]
[(empty? pattern) true]
[else (and (symbol=? (first pattern) (first search-string))
           (DNAprefix (rest pattern) (rest search-string)))]))

;; DNAprefix-mod : list-of-symbols list-of-symbols -> list-of-symbols or boolean
;; Returns remaining string if pattern is a proper prefix of search-string
;; Otherwise returns true if it's a prefix that is, the full word or false if it's not a prefix
(define (DNAprefix-mod pattern search-string)
  (cond
[(and (empty? pattern) (empty? search-string)) true]
[(empty? search-string) false]
[(empty? pattern) search-string]
[else (cond
        [(symbol=? (first pattern) (first search-string)) (DNAprefix-mod (rest pattern) (rest search-string))]
        [else false])]))

;; TESTS
(check-expect (DNAprefix (list 'a 't) (list 'a 't 'c)) true)
(check-expect (not (DNAprefix (list 'a 't) (list 'a))) true)
(check-expect (DNAprefix (list 'a 't) (list 'a 't)) true)
(check-expect (not (DNAprefix (list 'a 'c 'g 't) (list 'a 'g))) true)
(check-expect (not (DNAprefix (list 'a 'a 'c 'c) (list 'a 'c))) true)
(check-expect (DNAprefix empty (list 'a 'g)) true)

(check-expect (DNAprefix-mod (list 'a 't) (list 'a 't 'c 'g)) (list 'c 'g))
(check-expect (DNAprefix-mod (list 'a 'x) (list 'a 't 'c 'g)) false)
(check-expect (DNAprefix-mod (list 'a) (list 'a 't 'c 'g)) (list 't 'c 'g))
(check-expect (DNAprefix-mod empty (list 'a)) (list 'a))
