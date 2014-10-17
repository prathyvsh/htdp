#lang racket
(require lang/htdp-intermediate)

;; below : lon number  ->  lon
;; to construct a list of those numbers 
;; on alon that are below t
(define (below alon t)
  (local ((define (below-predicate x)
          (< x t)))
    (filter below-predicate alon)))

;; below : lon number  ->  lon
;; to construct a list of those numbers 
;; on alon that are below t
(define (above alon t)
  (local ((define (above-predicate x)
          (> x t)))
    (filter above-predicate alon)))

(define (filterout predicate alon)
  (cond
   [(empty? alon) empty]
   [else (cond
          [(predicate (first alon)) 
           (cons (first alon)
                 (filter predicate (rest alon)))]
          [else
           (filter predicate (rest alon))])]))

;; TESTS
(define incremental-list (list 3 4 5))
(define random-list (list 3 4 28 32))

(equal? (below incremental-list 10) (list 3 4 5))
(equal? (below incremental-list 5) (list 3 4))
(equal? (below random-list 15) (list 3 4)) 

(equal? (above incremental-list 10) empty)
(equal? (above incremental-list 5) empty)
(equal? (above random-list 15) (list 28 32)) 

