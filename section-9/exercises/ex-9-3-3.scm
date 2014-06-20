#|
;; TEMPLATE
(define (contains? list symbol)
  (cond
    [(empty? list) ...]
    [else ... (first list)
          ... (contains? (rest list) symbol) ...]))
|#
;; contains? : symbol list-of-symbols -> boolean
;; Deteremines if a-list contains a-symbol
;; EXAMPLE
;; (contains? (cons 'giraffe (cons 'chimpanzee empty)) 'giraffe)
;; should be true
;; (contains? (cons 'apple (cons 'lemon empty)) 'orange) should be
;; false
(define (contains? a-list a-symbol)
  (cond
    [(empty? a-list) false]
    [else (cond
            [(symbol=? (first a-list) a-symbol) true]
            [else (contains? (rest a-list) a-symbol)])]))

;; TESTS
(boolean=? (contains? (cons 'giraffe (cons 'chimpanzee empty)) 'giraffe) true)
(boolean=? (contains? (cons 'apple (cons 'lemon empty)) 'orange) false)
