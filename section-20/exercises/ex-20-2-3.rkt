#lang racket
(require lang/htdp-intermediate)

;; filter1 : (X TH  ->  boolean) (listof X) TH  ->  (listof X)
(define (filter1 rel-op alon t)
  (cond
    [(empty? alon) empty]
    [(rel-op (first alon) t) 
     (cons (first alon)
       (filter1 rel-op (rest alon) t))]
    [else
      (filter1 rel-op (rest alon) t)]))

;; filtercars : (listof symbols) -> (listof symbols)
(define (filter-cars alon)
  (filter1 symbol=? alon 'car))

;; TESTS
(define without-car (list 'rice 'mango 'notebook 'sloth))
(define with-car (list 'rice 'mango 'car 'notebook 'sloth))
(define more-cars (list 'rice 'car 'mango 'car 'notebook 'sloth))

(equal? (filter-cars without-car) '())
(equal? (filter-cars with-car) '(car))
(equal? (filter-cars more-cars) '(car car))
