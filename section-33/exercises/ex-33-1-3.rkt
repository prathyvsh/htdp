#lang racket
(require lang/htdp-intermediate-lambda)

;; add : number -> number
;; Adds $i1/185 n times
(define (add n)
  (cond
   [(= n 0) 0]
   [else (+ #i1/185 (add (sub1 n)))]))

(add 185) ; equals 0.9999999999999949 instead of 1
;; On multiplying a large number it becomes
;; increasingly inaccurate.

;; sub : number -> number
;; Subtracts a number n times from a given number
(define (sub n)
  (cond
   [(= n 0) 0]
   [else (+ 1 (sub (- n 1/185)))]))

;; (sub 1) recurs 185 times
;; whereas (sub #i1) never reaches 0 and hence enters an infinite loop.
