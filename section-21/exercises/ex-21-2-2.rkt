#lang racket
(require lang/htdp-intermediate)

;; euro->dollar : number -> number
;; Converts Euro to Dollar at the rate
;; of 1.22
(define (euro->dollar euro)
  (* euro 1.22))

;; convert-euro : (listof number) -> (listof number)
;; Converts a list of Euros to Dollars
(define (convert-euro eurolist)
  (map euro->dollar eurolist))

;; fahrenheit->celsius : number -> number
;; Converts fahrenheit to celsius
(define (fahrenheit->celsius fht)
  (* (/ 5 9) (- fht 32)))

;; convertFC : (listof number) -> (listof number)
;; Converts a list of farenheit temperatures to celsius
(define (convertFC fh-list)
  (map fahrenheit->celsius fh-list))

;; move-point : posn -> posn
;; Shifts the x position of a point by 3 units
(define (move-point p)
  (make-posn (+ (posn-x p) 3) (posn-y p)))

;; move-all : (listof posn) -> (listof posn)
;; Shifts x coordinate of all posns in the list by 3 units
(define (move-all posn-list)
  (map move-point posn-list))
  
;; TESTS
(equal? (convert-euro (list 3 4 5)) (list (* 1.22 3) (* 1.22 4) (* 1.22 5)))

(equal? (convertFC (list -40 32 212)) (list -40 0 100))

(equal? (move-all (list (make-posn 3 4) (make-posn 6 5)))
        (list (make-posn 6 4) (make-posn 9 5)))
