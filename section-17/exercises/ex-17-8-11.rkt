#lang racket
(require lang/htdp-beginner-abbr)

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

;; test-list-pick : list number symbol -> test-result
;; to test list-pick
(define (test-list-pick a-list number  expected-result)
  (cond
   [(equal? (list-pick a-list number) expected-result) true]
   [else (list "Bad result:" a-list number expected-result)]))

;; TESTS
(test-list-pick (list 'mango 'pomogranate 'kiwi) 3 'kiwi)
(test-list-pick (list 3 4 5 8 20) 5 20)
(test-list-pick (list 1 2 3) 3 4)
