;; gift-pick: list-of-names  ->  list-of-names
;; to pick a ``random'' non-identity arrangement of names
(define (gift-pick names)
  (random-pick
    (non-same names (arrangements names))))

;; random-pick : list-of-list-of-names -> list-of-names
;; Picks a random list-of-names from the given list-of-list-of-names
(define (random-pick lolon)
  (cond
    [(empty? lolon) empty]
    [else (pick (random (length lolon)) lolon)]))

;; pick : number list
;; Picks the element at the given number from the list
;; ASSUMPTION : Counting starts from 1.
(define (pick number list)
  (cond
    [(empty? list) empty]
    [else (cond
            [(= 1 number) (first list)]
            [else (pick (sub1 number) (rest list))])]))

;; non-same : list-of-names list-of-list-of-names ->
;; list-of-list-of-names
;; Creates a list of list-of-names which doesn't have any of the name at the
;; original location as the input
(define (non-same original combos)
  (cond
    [(empty? combos) empty]
    [else (cond
            [(distinct original (first combos)) (append (list (first combos))
                                                        (non-same original (rest combos)))]
            [else (non-same original (rest combos))])]))

;; distinct : list-of-symbols list-of-symbols -> boolean
;; Determines if word2 has distinct letters at every location compared
;; to word1
;; ASSUMPTION: word1 and word2 are of the same length
(define (distinct words1 words2)
  (cond
    [(empty? words1) true]
    [else (and (not (symbol=? (first words1) (first words2)))
               (distinct (rest words1) (rest words2)))]))

;; arrangements : word ->  list-of-words
;; to create a list of all rearrangements of the letters in a-word
(define (arrangements a-word)
  (cond
    [(empty? a-word) (cons empty empty)]
    [else (insert-everywhere/in-all-words (first a-word) 
                                          (arrangements (rest a-word)))]))

;; insert-everywhere : letter list-of-words -> list-of-words
;; to create a list of words with letter inserted between all
;; letters of the word
(define (insert-everywhere/in-all-words letter word-list)
  (cond
    [(empty? word-list) empty]
    [else (append (insert-everywhere letter (first word-list))
                  (insert-everywhere/in-all-words letter (rest word-list)))]))

;; insert-everywhere : letter word -> list-of-words
;; Prefixes letter at every location of the word and creates a list of
;; out it.
(define (insert-everywhere letter word)
  (cond
    [(empty? word) (cons (cons letter empty) empty)]
    [else (append (cons (append (cons letter empty) word) empty)
                  (prefix (cons (first word) empty) (insert-everywhere letter (rest word))))]))

;; prefix : word list-of-words -> list-of-words
;; Prefixes word on to every word in the word-list
(define (prefix word word-list)
  (cond
    [(empty? word-list) empty]
    [else (append (cons (append word (first word-list)) empty)
                  (prefix word (rest word-list)))]))

;; TESTS
(check-expect (pick 3 '(1 2 3)) 3)
(check-expect (pick 10 '(8 2 3 5 9 123 32 8 2 12)) 12)

(check-expect (distinct '(a) '(b)) true)
(check-expect (distinct '(a) '(a)) false)
(check-expect (distinct '(a b) '(b a)) true)
(check-expect (distinct '(x b) '(a b)) false)
(check-expect (distinct '(b a t) '(t b a)) true)
(check-expect (distinct '(b a t) '(t a b)) false)
(check-expect (distinct '(l l t e) '(t e l l)) true)

(check-expect (non-same '(h e) '((h e) (e h) (x e) (e x))) '((e h) (e x)))
(check-expect (non-same '(s e t) (arrangements '(s e t))) '((e t s) (t s e)))

;; Owing to the nature of random generation in gift-pick.
(define sisters '(Loise Jane Laura Dana Mary))
(check-expect (distinct sisters (gift-pick sisters)) true)
(check-expect (distinct sisters (gift-pick sisters)) true)
(check-expect (distinct sisters (gift-pick sisters)) true)
(check-expect (distinct sisters (gift-pick sisters)) true)
(check-expect (distinct sisters (gift-pick sisters)) true)
