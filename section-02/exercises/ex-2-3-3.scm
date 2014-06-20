; cost : number -> number
; cost incurred by theatre for a show
(define (cost attendees)
  (+ (* 0.50 attendees) 20))

; revenue : number -> number
; revenue earned per attendee
(define (revenue attendees)
  (* 5 attendees))


; total-profit : number -> number
; profit earned per attendee
(define (total-profit attendees)
  (- (revenue attendees) (cost attendees)))

; TESTS
(total-profit 5)
(total-profit 10)
(total-profit 50)
