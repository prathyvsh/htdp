#lang racket
(require lang/htdp-intermediate-lambda)

;; subtract: (listof number) (listof number) -> (listof number)
;; Subtracts first list from the second and returns a list with
;; first 0 omitted.
(define (subtract l1 l2)
  (cond
   [(empty? l1) l2]
   [else (local ((define (equalizer x) (* x (/ (first l2) (first l1)))))
           (rest (subtract-list (map equalizer l1) l2)))]))

;; subtract-list : (listof number) (listof number) -> (listof number)
;; Subtracts two lists.
(define (subtract-list l1 l2)
  (cond
   [(and (empty? l1) (empty? l2)) empty]
   [(and (cons? l1) (cons? l2)) (cons (- (first l2) (first l1)) (subtract-list (rest l1) (rest l2)))]
   [else (error 'subtract-list "Cannot subtract list with different length")]))

;; TESTS

(equal? (subtract-list (list 0 0) (list 0 0)) (list 0 0))
(equal? (subtract-list (list 3 4 5) (list 4 5 6)) (list 1 1 1))

(equal? (subtract (list 2 3 4) (list 2 4 0)) (list 1 -4))
(equal? (subtract (list  2 2 3 10) (list 2 5 12 31)) (list 3 9 21))
(equal? (subtract (list  2 2 3 10) (list 4 1 -2 1)) (list -3 -8 -19))
