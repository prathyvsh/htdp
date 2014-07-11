;; DATA DEFINITION

;; A natural number is either
;; 1. 0 or
;; 2. (add1 n) if n is a natural number.

;; A list-of-symbols is either

;; the empty list, empty, or

;; (cons s lof) where s is a symbol and lof is a list of symbols.

;;; list-pick : list-of-symbols  ->  symbol
;; to determine the nth symbol from alos, counting from 1;
;; signals an error if there is no nth item
(define (list-pick0 alos n)
  (cond
    [(and (>= n 0) (empty? alos)) (error 'list-pick0 "list too short")]
    [(and (= n 0) (cons? alos)) (first alos)]
    [(and (> n 0) (cons? alos)) (list-pick0 (rest alos) (sub1 n))]));

;; TESTS
(symbol=? (list-pick0 (list 'a 'b 'c 'd) 3) 'd) "****"
"expected behaviour list-pick0: the list too short"
(list-pick0 (list 'a 'b 'c 'd) 4) 
