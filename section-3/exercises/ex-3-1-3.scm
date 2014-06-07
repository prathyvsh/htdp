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
(define (profit-1 ticket-price)
  (- (revenue ticket-price) (cost ticket-price)))

(define (profit-2 price) 
  (- (* (+ 120 
           (* (/ 15 .10) 
              (- 5.00 price))) 
        price) 
     (+ 180  
        (* .04 
           (+ 120 
              (* (/ 15 .10) 
                 (- 5.00 price))))))) 
;; COMPUTATIONS
(profit-1 3)
(profit-1 4)
(profit-1 5)

(profit-2 3)
(profit-2 4)
(profit-2 5)

