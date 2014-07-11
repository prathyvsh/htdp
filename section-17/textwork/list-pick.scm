;; DATA DEFINITION

;; A natural number [>= 1] (N[>= 1]) is either
;; 1. 1 or
;; 2. (add1 n) if n is a N[>= 1].

;; A list-of-symbols is either

;; the empty list, empty, or

;; (cons s lof) where s is a symbol and lof is a list of symbols.

;; list-pick : list-of-symbols N[>= 1]  ->  symbol
;; to determine the nth symbol from alos, counting from 1;
;; signals an error if there is no nth item
(define (list-pick alos n)
  (cond
    [(and (= n 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (> n 1) (empty? alos)) (error 'list-pick "list too short")]
    [(and (= n 1) (cons? alos)) (first alos)]
    [(and (> n 1) (cons? alos)) (list-pick (rest alos) (sub1 n))]));
