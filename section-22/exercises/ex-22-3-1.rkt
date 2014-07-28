#lang racket
(require lang/htdp-intermediate)
(require htdp/gui)

;; Model:
;; build-number : (listof digit)  ->  number
;; to translate a list of digits into a number
;; example: (build-number (list 1 2 3)) = 123
(define (build-number x)
  (cond
    [(empty? x) 0]
    [else (+ (* (expt 10 (- (list-length x) 1)) (first x)) (build-number (rest x)))]))

;; list-length: (listof X) -> number
;; Calculates the length of the list
(define (list-length list)
(local ((define (count x y) (+ 1 y)))
  (foldl count 0 list)))

;; random-n-m : integer integer -> integer
;; Assume n < m
(define (random-n-m n m)
  (+ (random (- m n))))

;; check-guess-for-list number number -> symbol
(define (check-guess-for-list list-of-digits target)
  (cond
  [(< (build-number list-of-digits) target) "Too Small"]
  [(= (build-number list-of-digits) target) "Perfect"]
  [(> (build-number list-of-digits) target) "TooLarge"]))

;; View:
;; the ten digits as strings
(define DIGITS
  (build-list 10  number->string))

(define DIGIT-COUNT 4)

(define TARGET (local ((define (random-digit i)
                         (random 10)))
                         (build-number (build-list DIGIT-COUNT random-digit))))

;; a list of three digit choice menus 
(define digit-choosers
  (local ((define (builder i) (make-choice DIGITS)))
    (build-list DIGIT-COUNT builder)))

;; generate-random-n-digit-number : number -> number
;; Generates a random n digit number
(define (generate-random-n-digit-number digit)
  (random-n-m (expt 10 (- digit 1)) (expt 10 digit)))

;; a message field for saying hello and displaying the number 
(define a-msg (make-message "Welcome"))

;; Controller: 
;; Enter a positive integer

;; check-call-back : X  ->  true
;; to get the current choices of digits, convert them to a number, 
;; and to draw this number as a string into the message field 
(define (check-call-back b)
  (draw-message a-msg (check-guess-for-list (map choice-index digit-choosers) TARGET)))

(create-window 
 (list 
  (append digit-choosers (list a-msg))
  (list (make-button "Check Guess" check-call-back))))
