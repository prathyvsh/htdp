#lang racket
(require lang/htdp-intermediate-lambda)

;; make-palindrome : (listof symbol) -> (listof symbol)
;; Creates a palindrome word from the given word
(define (make-palindrome los)
  (append los (accrue-before-last los)))

;; accrue-before-last : (listof symbol) -> (listof symbol)
;; Collects all the elements of the list but last
(define (accrue-before-last los)
  (local ((define (accrue los acc)
            (cond
             [(empty? (rest los)) acc]
             [else (accrue (rest los) (cons (first los) acc))])))
    (accrue los empty)))

;; TESTS
(equal? (accrue-before-last '(h e l l o)) '(l l e h))
(equal? (make-palindrome '(h e l l o)) '(h e l l o l l e h))
(equal? (make-palindrome '(a b c)) '(a b c b a))
            
  
