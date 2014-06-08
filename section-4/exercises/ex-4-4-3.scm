;; Thresholds and Returns
(define threshold-1 500)
(define threshold-2 1500)
(define threshold-3 2500)

(define return1 0.0025)
(define return2 0.005)
(define return3 0.0075)
(define return4 0.01)

;; pay-back number -> number
;; Computes the pay back amount for a given amount of money

(define (pay-back amount)
  (cond
    [(<= amount threshold-1) (first-pay amount)]
    [(<= amount threshold-2) (second-pay amount)]
    [(<= amount threshold-3) (third-pay amount)]
    [(> amount threshold-3) (fourth-pay amount)]))


;; first-pay number -> number
;; Computes the payment for the first threshold
(define (first-pay amount)
  (* amount return1))

;; second-pay number -> number
;; Computes the payment for the second threshold
(define (second-pay amount)
  (+ (first-pay threshold-1)
   (* (- amount threshold-1) return2)))

;; third-pay number -> number
;; Computes the payment for the third threshold
(define (third-pay amount)
  (+ (second-pay threshold-2)
     (* (- amount threshold-2) return3)))

;; fourth-pay number -> number
;; Computes the payment beyond third threshold
(define (fourth-pay amount)
  (+ (third-pay threshold-3)
     (* (- amount threshold-3) return4)))

;; TESTS
(= (pay-back 400) 1)
(= (pay-back 1400) 5.75)
(= (pay-back 2000) 10)
(= (pay-back 2600) 14.75)
