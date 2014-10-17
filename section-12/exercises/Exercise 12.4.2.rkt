#lang racket
(require lang/htdp-beginner)

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
                  (prefix-word (cons (first word) empty) (insert-everywhere letter (rest word))))]))

;; prefix : word list-of-words -> list-of-words
;; Prefixes word on to every word in the word-list
(define (prefix-word word word-list)
  (cond
    [(empty? word-list) empty]
    [else (append (cons (append word (first word-list)) empty)
                  (prefix-word word (rest word-list)))]))

;; TESTS
(arrangements (cons 'a (cons 'n (cons 'd empty))))
