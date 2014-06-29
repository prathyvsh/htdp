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
  [else (append (insert-everywhere empty letter (first word-list))
                (insert-everywhere/in-all-words letter (rest word-list)))]))

;; insert-everywhere : empty symbol word -> list-of-word
;; Returns a list of words with symbol inserted at every location of the
;; word
(define (insert-everywhere start letter end)
  (cond
    [(empty? end) (cons (append start (cons letter empty) end) empty)]
    [else (append
           (cons (append start (cons letter empty) end) empty)
           (insert-everywhere (append start (cons (first end) empty)) letter (rest end)))]))


;; TESTS
(arrangements (cons 'a (cons 'n (cons 'd empty))))
