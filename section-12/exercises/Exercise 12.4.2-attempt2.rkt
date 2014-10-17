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
  [else (append (insert-front (list letter) (first word-list))
                (insert-everywhere/in-all-words letter (rest word-list)))]))

;; insert-front word word -> list-of-word
(define (insert-front prefix word)
  (cond
    [(empty? word) (list prefix)]
    [else (append (list (append prefix word))
                  (insert-front (append (list (first word)) prefix) (rest word)))]))
