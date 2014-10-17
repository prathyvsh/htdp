;; arrangements : word  ->  list-of-words
;; to create a list of all rearrangements of the letters in a-word
(define (arrangements a-word)
  (cond
    [(empty? a-word) (cons empty empty)]
    [else (insert-everywhere/in-all-words (first a-word) 
            (arrangements (rest a-word)))]))

;; TESTS
(arrangements (cons 'a (cons 'n (cons 'd empty))))

