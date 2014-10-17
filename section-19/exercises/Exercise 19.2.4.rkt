#lang racket
(require lang/htdp-intermediate)

#|
A (non-empty-listof ITEM) is either

(cons s empty), or
(cons s l) where l is a (non-empty-listof ITEM)

and s is always an ITEM.
|#

;; last : (non-empty-listof ITEM) -> ITEM
(define (last-of loi)
  (cond
   [(empty? (rest loi)) (first loi)]
   [else (last-of (rest loi))]))

;; TESTS
(define list1 (cons 'symbol empty))
(define list2 (cons 3 (cons 5 empty)))
(define list3 (cons true (cons false (cons true (cons false empty)))))

(equal? (last-of list1) 'symbol)
(equal? (last-of list2) 5)
(equal? (last-of list3) false)
