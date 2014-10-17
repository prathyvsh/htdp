#lang racket
(require lang/htdp-intermediate)

;; maxi : non-empty-lon  ->  number
;; to determine the largest number on alon
(define (maxi alon)
  (cond
   [(empty? (rest alon)) (first alon)]
   [else (cond
          [(> (first alon) (maxi (rest alon))) (first alon)]
          [else (maxi (rest alon))])]))

;; maxi-alt : non-empty-lon  ->  number
;; to determine the largest number on alon
(define (maxi-alt alon)
  (cond
   [(empty? (rest alon)) (first alon)]
   [else (local ((define r (maxi-alt (rest alon))))
            (cond
            [(> (first alon) r) (first alon)]
            [else r]))]))

;; TESTS
(maxi (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))
(maxi-alt (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20))

;; maxi-alt seems like it requires less computations since maxi-alt
;; stores the computed result as r and hence as in the original version
;; it doesn't have to recompute the result of maxi (rest alon) again.
