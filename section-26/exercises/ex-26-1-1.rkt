#lang racket
(require lang/htdp-intermediate-lambda)

;; tabulate-div : number -> (listof number)
;; Structurally Recursive Solution
(define (tabulate-div n)
  (filter (lambda (divisor) (= (remainder n divisor) 0))
          (build-list n add1)))

;; TESTS
(equal? (tabulate-div 30) (list 1 2 3 5 6 10 15 30))
