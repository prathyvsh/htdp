#lang racket
(require lang/htdp-beginner)

;; tax number -> number
;; Computes the tax rate for a given amonut of pay
(define (tax gross-pay)
  (cond
    [(<= gross-pay 240) 0]
    [(<= gross-pay 480) (* 0.15 gross-pay)]
    [(> gross-pay 480) (* 0.28 gross-pay)]
    ))


(define hourly-rate 12)

(define (grosspay hours)
  (* hours hourly-rate))

;; netpay number number -> number
;; Computes the net payment of an employee given the number of hours.
(define (netpay hours)
  (- (grosspay hours) (tax (grosspay hours))))

;; TESTS
(= (tax 100) 0)
(= (tax 240) 0)
(= (tax 400) (* 0.15 400))
(= (tax 480) (* 0.15 480))
(= (tax 600) (* 0.28 600))

(= (grosspay 20) (* 20 hourly-rate))
(= (grosspay 40) (* 40 hourly-rate))
(= (grosspay 50) (* 50 hourly-rate))

(= (netpay 20) 240)
(= (netpay 40) 408)
(= (netpay 50) 432)
