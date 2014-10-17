#lang racket
(require lang/htdp-intermediate-lambda)

;; add-to-pi : number -> number
;; Adds a given number to pi
(define (add-to-pi num)
  ;; acc represents the difference from num
  ;; added so far.
  (local ((define (add-to-pi-acc num acc)
          (cond
           [(= num 0) acc]
           [else (add-to-pi-acc (sub1 num) (add1 acc))])))
    (add-to-pi-acc num pi)))

;; add-to-pi : number -> number
;; Adds a given number to pi
(define (add-to-any num1 num2)
  ;; acc represents the difference from num
  ;; added so far.
  (local ((define (add-to-pi-acc num acc)
          (cond
           [(= num 0) acc]
           [else (add-to-pi-acc (sub1 num) (add1 acc))])))
    (add-to-pi-acc num1 num2)))

;; TESTS
(equal? (add-to-pi 3) (+ 3 pi))
(equal? (add-to-pi 0) pi)
(equal? (add-to-any 2 6) 8)
(equal? (add-to-any 4 4) 8)
(equal? (add-to-any 8 0) 8)



           
