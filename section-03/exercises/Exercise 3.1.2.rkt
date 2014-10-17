#lang racket
(require lang/htdp-beginner)

;; attendees : number -> number
;; To compute the number of attendees, given ticket-price
(define (attendees ticket-price) 
  (+ 120
     (* (/ (- 5 ticket-price) 0.10) 15)))

;; cost : number -> number
;; To compute the cost, given ticket-price
(define (cost ticket-price) (+ 180 (* 0.04 (attendees ticket-price))))


;; revenue : number -> number
;; To compute the revenue, given ticket-price
(define (revenue ticket-price)
  (* (attendees ticket-price) ticket-price))


;; profit : number -> number
;; Profit as the difference between revenue and costs of a
;; given ticket price
(define (profit ticket-price)
  (- (revenue ticket-price) (cost ticket-price)))

;; COMPUTATIONS
(cost 3)
(cost 4)
(cost 5)

(revenue 3)
(revenue 4)
(revenue 5)

(profit 3)
(profit 4)
(profit 5)
