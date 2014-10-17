#lang racket
(require lang/htdp-intermediate-lambda)

;; product : (listof number) -> number
;; Multiplies all the elements in the given list
(define (product p)
  ;; acc represents the product of all the numbers seen so far
  (local ((define (product-acc p acc)
            (cond
            [(empty? p) acc]
            [else (product-acc (rest p) (* acc (first p)))])))
  (product-acc p 1)))

;; TESTS
(equal? (product (list 1 2 3)) 6)
(equal? (product (list 4 6 1)) 24)
