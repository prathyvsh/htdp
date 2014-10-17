#lang racket
(require lang/htdp-intermediate-lambda)

;; relative-2-absolute : (listof number)  ->  (listof number)
;; to convert a list of relative distances to a list of absolute distances
;; the first item on the list represents the distance to the origin
(define (relative-2-absolute alon)
  (cond
    [(empty? alon) empty]
    [else (cons (first alon)
	        (add-to-each (first alon) (relative-2-absolute (rest alon))))]))

;; add-to-each : number (listof number)  ->  (listof number)
;; to add n to each number on alon
(define (add-to-each n alon)
  (map (lambda (x) (+ x n)) alon))

;; TESTS
(equal? (relative-2-absolute (list 0 50 40 70 30 30))
        (list 0 50 90 160 190 220))

;; For each execution of relative-2-absolute for a list of
;; size N, it requires N calls to add-to-each which in turn
;; requires N calls for a list of length N. Thus it requires
;; O(N^2) time.
