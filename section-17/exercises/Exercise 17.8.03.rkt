#lang racket
(require lang/htdp-beginner-abbr)

;; sym-list=? : list-of-numbers list-of-numbers  ->  boolean
;; to determine whether a-list and another-list 
;; contain the same symbols in the same order
(define (sym-list=? a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [(cons? a-list)
     (and (cons? another-list)
          (symbol=? (first a-list) (first another-list))
          (sym-list=? (rest a-list) (rest another-list)))]))

;; TESTS
(check-expect (sym-list=? '(apple orange banana) '(apple orange banana)) true)
(check-expect (sym-list=? '(apple orange banana) '(apple orange kiwi)) false)
(check-expect (sym-list=? empty '(apple orange kiwi)) false)
(check-expect (sym-list=? empty empty ) true)

