#lang racket
(require lang/htdp-beginner)

;; STEPS
;;(attendees 5) = "120"
;;(attendees 4.90) = "135"
;;(attendees 4.80) = "150"
;;(attendees 4.00) = "270"
;;
;;(attendees 5) = "120"
;;(attendees 4.90) = "120 + 1 * 15"
;;(attendees 4.80) = "120 + 2 * 15"
;;(attendees 4.00) = "120 + 10 * 15"
;;
;;
;;(attendees 5) = "120"
;;(attendees 4.90) = "120 + ((5 - 4.90)/0.10) * 15"
;;(attendees 4.80) = "120 + ((5 - 4.80)/0.10) * 15"
;;(attendees 4.00) = "120 + ((5 - 4)/10) * 15"
;;
;; attendees : number -> number
;; To compute the number of attendees, given ticket-price
(define (attendees ticket-price) 
  (+ 120
     (* (/ (- 5 ticket-price) 0.10) 15)))


(attendees 5) "= 120"
(attendees 4.90) "= 135"
(attendees 4.80) "= 150"
(attendees 4.00) "= 120+150"

