#lang racket
(require lang/htdp-intermediate)

;; trapezoid-area : number number number -> number
;; Computes the area of a trapezoid with the given dimensions
(define (trapezoid-area base1 base2 height)
  (abs (* (/ (+ base1 base2) 2) height)))

;; integrate-kepler -> (number -> number) number number -> number
;; Computing integration using Kepler's method
(define (integrate-kepler fn a b)
  (local ((define mid (+ a (/ b 2)))
          (define fn-at-a (fn a))
          (define fn-at-b (fn b))
          (define fn-at-mid (fn mid))
          ;; Calculating area of the trapezoid. The trapezoid bases are f(a) and f(mid)
          (define first-trapezoid-area
            (trapezoid-area fn-at-a fn-at-mid (/ b 2)))
          (define second-trapezoid-area
            (trapezoid-area fn-at-mid fn-at-b (abs (- a (/ b 2))))))
    (+ first-trapezoid-area second-trapezoid-area)))

(define (one x) 1)
(define (square x) (* x x))

;; TESTS
(equal? (trapezoid-area 4 4 3) 12)
(equal? (integrate-kepler one 0 1) 1)
(equal? (integrate-kepler one 1 4) 3)
(equal? (integrate-kepler square 0 1) 3/8)

