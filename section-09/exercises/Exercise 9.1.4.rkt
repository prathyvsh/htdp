#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
;; (cons x (cons y empty))
;; where x and y are symbols.

(define (contains-doll? symbol)
  (or (symbol=? (first symbol) 'doll)
  (symbol=? (first (rest symbol)) 'doll)
  ))

;; TESTS
(contains-doll? (cons 'ping (cons 'pong empty))) "should be" false
(contains-doll? (cons 'ping (cons 'doll empty)))
(contains-doll? (cons 'doll (cons 'blue empty)))
