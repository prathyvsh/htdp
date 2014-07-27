#lang racket
(require htdp/gui)
(require lang/htdp-intermediate)

;; Not working
;;(create-window (list (list (make-button "Close" hide-window))))

;;(define a-text-field (make-text "Enter Text:"))

;;(define a-message (make-message "`Hello World' is a silly program."))

;; echo-message : X  ->  true
;; to extract the contents of a-text-field and to draw it into a-message 
;;(define (echo-message e) (draw-message a-message (text-contents a-text-field)))

;;(create-window (list (list a-text-field a-message) (list (make-button "Copy Now" echo-message))))

(define THE-CHOICES
  (list "green" "red" "yellow"))

(define a-choice
  (make-choice THE-CHOICES))

(define a-message
  (make-message (first THE-CHOICES)))

;; echo-choice : X  ->  true
;; to determine the current choice of a-choice and
;; to draw the corresponding string into a-message 
(define (echo-choice e)
  (draw-message a-message
                (list-ref THE-CHOICES
		          (choice-index a-choice))))

(create-window
 (list (list a-choice a-message)
       (list (make-button "Confirm Choice" echo-choice))))
