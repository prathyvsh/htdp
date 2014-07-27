#lang racket
(require lang/htdp-intermediate)

;; Model:
;; build-number : (listof digit)  ->  number
;; to translate a list of digits into a number
;; example: (build-number (list 1 2 3)) = 123
(define (build-number x) ...)



;; View:
;; the ten digits as strings 
(define DIGITS
  (build-list 10 number->string))

;; a list of three digit choice menus 
(define digit-choosers
  (local ((define (builder i) (make-choice DIGITS)))
    (build-list 3 builder)))

;; a message field for saying hello and displaying the number 
(define a-msg (make-message "Welcome"))

;; Controller: 
;; check-call-back : X  ->  true
;; to get the current choices of digits, convert them to a number, 
;; and to draw this number as a string into the message field 
(define (check-call-back b)
  (draw-message a-msg 
                ( number-> string
                 (build-number 
                  (map choice-index digit-choosers)))))

(create-window 
 (list 
  (append digit-choosers (list a-msg))
  (list (make-button "Check Guess" check-call-back))))
