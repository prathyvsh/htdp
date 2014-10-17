#lang racket
(require lang/htdp-intermediate-lambda)

;; find-threshold : number -> number
;; Finds the threshold after which (expt #i10. n) is +inf.0
(define (find-threshold n)
  (cond
    [(= (expt #i10. n) +inf.0) (- n 1)]
    [else (find-threshold (+ n 1))]))
