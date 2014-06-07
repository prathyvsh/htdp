;; VARIABLE DEFINITIONS
(define BASE-ATTENDEES 120)
(define BASE-COST 5)
(define DISCOUNT 0.10)
(define INCREASE-IN-ATTENDEES 15)
(define FIXED-COST 180)
(define PER-ATTENDEE-COST 0.04)

;; attendees : number -> number
;; To compute the number of attendees, given ticket-price
(define (attendees ticket-price) 
  (+ BASE-ATTENDEES
     (* (/ (- BASE-COST ticket-price) DISCOUNT) INCREASE-IN-ATTENDEES)))

;; cost : number -> number
;; To compute the cost, given ticket-price
(define (cost ticket-price)
  (+ FIXED-COST 
     (* PER-ATTENDEE-COST (attendees ticket-price))))

;; revenue : number -> number
;; To compute the revenue, given ticket-price
(define (revenue ticket-price)
  (* (attendees ticket-price) ticket-price))


;; profit : number -> number
;; Profit as the difference between revenue and costs of a
;; given ticket price
(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; COMPUTATIONS
(profit 3)
(profit 4)
(profit 5)
