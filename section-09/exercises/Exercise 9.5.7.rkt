#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
(define (template-for-toy-list toy-price-list)
  (cond
    [(empty? toy-price-list) ...]
    [... (first toy-price-list) ... (template-for-toy-list (rest toy-price-list))]))
|#

;; count-items : list-of-toy-prices -> number
;; Counts the number of items in toy-price-list
(define (count-items toy-price-list)
  (cond
    [(empty? toy-price-list) 0]
    [else (+ 1 (count-items (rest toy-price-list)))]))


;; total-price : list-of-toy-prices -> number
;; Sums up all the prices in toy-price-list
(define (total-price toy-price-list)
  (cond
    [(empty? toy-price-list) 0]
    [else (+  (first toy-price-list) (total-price (rest toy-price-list)))]))

;; average-price : list-of-toy-prices -> number
;; Calculates average-price of list-of-toy-prices
(define (average-price toy-price-list)
  (/ (total-price toy-price-list) (count-items toy-price-list)))


;; checked-average-price : list-of-toy-prices -> number
;; Checked average-price function that avoids performing averaging of empty lists.
(define (checked-average-price toy-price-list)
  (cond
    [(empty? toy-price-list) (error 'checked-average-price "Cannot perform this operation on an empty list")]
    [else (average-price toy-price-list)]))

;; TESTS
(define toy-list (cons 0 (cons 3 (cons 10 (cons 7 empty)))))
(define toy-list-2 (cons 20 (cons 20 (cons 20 empty))))

(= (average-price toy-list) 5)
(= (average-price toy-list-2) 20)

(checked-average-price empty)
