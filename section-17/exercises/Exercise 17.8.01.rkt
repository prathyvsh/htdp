#lang racket
(require lang/htdp-beginner-abbr)

;; list=? : list-of-numbers list-of-numbers  ->  boolean
;; to determine whether a-list and another-list 
;; contain the same numbers in the same order
(define (list=? a-list another-list)
  (cond
    [(and (empty? a-list) (empty? another-list)) true]
    [(and (cons? a-list) (empty? another-list)) false]
    [(and (empty? a-list) (cons? another-list)) false]
    [(and (cons? a-list) (cons? another-list))
     (and (= (first a-list) (first another-list))
          (list=? (rest a-list) (rest another-list)))]))

;; list=?-alt : list-of-numbers list-of-numbers  ->  boolean
;; to determine whether a-list and another-list 
;; contain the same numbers in the same order
(define (list=?-alt a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [(cons? a-list)
     (and (cons? another-list)
          (and (= (first a-list) (first another-list))
               (list=? (rest a-list) (rest another-list))))]))

;; TESTS
(define list1 '(1 3 5 7 8))
(define list2 '(1 2 5 128))
(define list3 '(128 2 3 5))
(define list4 '(1 2))
(define list5 '(3 4))
(define list6 '(1 2 5 128))

(check-expect (list=? list1 list2) false)
(check-expect (list=? list4 list5) false)
(check-expect (list=? list2 list6) true)
(check-expect (list=?-alt list1 list2) false)
(check-expect (list=?-alt list4 list5) false)
(check-expect (list=?-alt list2 list6) true)

