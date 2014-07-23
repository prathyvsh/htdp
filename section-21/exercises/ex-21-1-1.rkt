#lang racket
(require lang/htdp-intermediate)

;; tabulate : (number -> number) number -> (listof number)
;; Tabulates the result of applying fn to numbers
;; from [0, n]
(define (tabulate fn n)
  (cond
   [(= n 0) (list (fn 0))]
   [else
    (cons (fn n) (tabulate fn (sub1 n)))]))

;; tabulate-sin : number  ->  lon
;; to tabulate sin between n 
;; and 0 (inclusive) in a list
(define (tabulate-sin n)
  (tabulate sin n))

;; tabulate-sqrt : number  ->  lon
;; to tabulate sqrt between n 
;; and 0 (inclusive) in a list
(define (tabulate-sqrt n)
  (tabulate sqrt n))

;; TESTS

(define sin-list (list (sin 2) (sin 1) (sin 0)))
(define sqrt-list (list (sqrt 4) (sqrt 3) (sqrt 2) (sqrt 1) (sqrt 0)))

(equal? (tabulate-sin 2) sin-list)
(equal? (tabulate-sqrt 4) sqrt-list)
