#lang racket
(require lang/htdp-intermediate-lambda)

;; quick-sort : (listof number)  ->  (listof number)
;; to create a list of numbers with the same numbers as
;; alon sorted in ascending order
;; assume that the numbers are all distinct 
(define (quick-sort alon)
  (cond
    [(empty? alon) empty]
    [else (append (quick-sort (smaller-items (rest alon) (first alon)))
                  (list (first alon))
		  (quick-sort (larger-items (rest alon) (first alon))))]))

;; larger-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are larger than threshold
(define (larger-items alon threshold)
  (filter (lambda (value) (>= value threshold)) alon))

;; smaller-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are smaller than threshold
(define (smaller-items alon threshold)
  (filter (lambda (value) (< value threshold)) alon))

;; TESTS
(quick-sort (list 3 2 4 2 8 10))
