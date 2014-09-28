#lang racket
(require lang/htdp-advanced)

(define COUNT 100)

;; histogram : (listof number) -> (vectorof number)
(define (histogram grades)
  (local ((define hist-vect (build-vector (add1 COUNT) (lambda (i) 0))))
    (cond
     [(empty? grades) hist-vect]
     [else (histogram-aux hist-vect grades)])))

;; histogram-aux : (listof vector) -> (vectorof number)
;; Builds a histogram with a list of vector
(define (histogram-aux hist grades)
  (cond
   [(empty? grades) hist]
   [else
    (local ((define value (vector-ref hist (first grades))))
      (begin (vector-set! hist (first grades) (add1 value))
             (histogram-aux hist (rest grades))))]))

;; TESTS
;; generate-random : number -> (listof number)
(define (generate-random count)
  (build-list count (lambda (i) (random COUNT))))

(define hist (generate-random COUNT))
(histogram hist)
