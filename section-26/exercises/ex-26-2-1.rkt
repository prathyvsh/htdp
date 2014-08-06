#lang racket
(require lang/htdp-intermediate-lambda)

#|
(define (generative-recursive-fun problem)
  (cond
    [(empty? problem) (determine-solution problem)]
    [else
      (combine-solutions
	problem
	(generative-recursive-fun (rest problem)))]))
|#

(define (length-calculator list)
  (cond
    [(empty? list) 0]
    [else
      (+ 1 (length-calculator (rest list)))]))

(length-calculator (list 2 3))

;; determine-solution : 0
;; combine-solution : +
