#lang racket

; COMMENTS
; It was not clear in the problem definition that netpay
; required to discount the tax from it.

; wage : number -> number
; Wage for hours worked at $12 per hour
(define (wage h)
  (* 12 h))

; tax : number -> number
; 15% tax for given amount of pay
(define (tax pay)
  (* 15/100 pay))

; netpay : number -> number
; Net pay of an employee per hour
(define (netpay h)
  (- (wage h) (tax (wage h))))


; TESTS
(tax 350)
(tax 1000)

(netpay 20)
(netpay 100)
(netpay 140)

(tax 100)
(wage 2)
(netpay 40)
