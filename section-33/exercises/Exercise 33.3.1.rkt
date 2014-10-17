#lang racket
(require lang/htdp-intermediate-lambda)

;;find-lower-threshold : number -> number
;; Finds the lowest number after which
;; (expt #i10. n) gives #i0
(define (find-lower-threshold n)
  (cond
   [(= (expt #i10. n) #i0) (+ n 1)]
   [else (find-lower-threshold (sub1 n))]))

(find-lower-threshold 0)
