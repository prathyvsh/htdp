#lang racket
(require lang/htdp-beginner)

;; interest : number -> number
;; Calculates the amount of interest for a given amount
(define (interest amount)
(cond
  [(<= amount 1000) (* .040 amount)]
  [(<= amount 5000) (* .045 amount)]
  [(<= amount 10000) (* .055 amount)]
  [(> amount 10000) (* .060 amount)]))

;; TESTS
(= (interest 500) 20)
(= (interest 1000) 40)
(= (interest 4000) 180)
(= (interest 5000) 225)
(= (interest 8000) 440)
(= (interest 10000) 550)
(= (interest 12000) 720)
