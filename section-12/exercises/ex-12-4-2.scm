;; arrangements : word ->  list-of-words
;; to create a list of all rearrangements of the letters in a-word
(define (arrangements a-word)
  (cond
    [(empty? a-word) (cons empty empty)]
    [else (insert-everywhere/in-all-words (first a-word) 
            (arrangements (rest a-word)))]))

;;b -> de
bde
dbe
deb

;;b -> ed
bed
ebd
edb


;; insert-everywhere : letter list-of-words -> list-of-words
;; to create a list of words with letter inserted between all
;; letters of the word
The result is a list of words like its second argument, but with the first argument inserted between all letters and at the beginning and the end of all words of the second argument.

;a -> ([]) : ([a, []], ([]))
;b -> ([a, []]) : ([b + [a, []], (a + b -> ([])))
;c -> ([b, [a, []]]) : ([c, [b, [a, []]]]), [b] + c -> ([a, []])


(define (insert-everywhere/in-all-words letter word-list)
  (cond
    [(empty? word-list) (cons empty empty)]
    [else (cond
            [(empty? (first word-list)) (append (cons (cons letter empty) empty)
                                                (insert-everywhere/in-all-words (rest word-list)))]
            [(else (append (cons (prepend letter (first word-list)) empty)
                           (prepend (first (first word-list))
                                    (insert-everywhere/in-all-words letter (rest word-list)))))])]))


;; insert-before : letter word -> list-of-word
;; Creates a list of words with letter inserted before every letter
(define (insert-before-all letter word)
  (cond
    [(empty? word) (cons letter empty)]
    [else (append
            (cons letter (first word) empty)
            (cons letter (insert-before-all letter (rest word))))]))

;; TESTS
;;(arrangements (cons 'a (cons 'n (cons 'd empty))))
