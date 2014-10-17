#lang racket
(require lang/htdp-intermediate-lambda)

;; how-many : (listof number) -> number
;; Counts the number of elements in the given list
(define (how-many l)
  ;; acc represents the number of elements counted so far in the list
  (local ((define (how-many-acc l acc)
            (cond
             [(empty? l) acc]
             [else (how-many-acc (rest l) (+ 1 acc))])))
    (how-many-acc l 0)))


;; TESTS
(equal? (how-many (list 2 3 4 5 6 7)) 6)
(equal? (how-many (list 6 7)) 2)
