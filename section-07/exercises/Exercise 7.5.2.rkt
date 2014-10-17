#lang racket
(require lang/htdp-beginner)

;; checked-profit : number -> number
;; Calculates profit for a given ticket price
(define (checked-profit ticket-price)
  (cond
    [(and (number? ticket-price) (< ticket-price 5)) (- (revenue ticket-price)
     (cost ticket-price))]
    [else (error 'checked-profit "A number less than five expected")]
    ))

(define (revenue ticket-price)
  (*  (attendees ticket-price) ticket-price))

(define (cost ticket-price)
  (+ 180 
     (* .04 (attendees ticket-price))))

(define (attendees ticket-price)
  (+ 120
     (* (/ 15 .10) (- 5.00 ticket-price))))

;;TESTS
(checked-profit 3)
;;(checked-profit 8)
;;(checked-profit "Hello")

;; is-between-5-6? : number  ->  boolean
;; to determine whether n is between 5 and 6 (exclusive)
(define (checked-is-between-5-6? n)
  (cond
    [(number? n) (and (< 5 n) (< n 6))]
    [else (error 'checked-is-between-5-6? "A number expected")]))

;;TESTS
(checked-is-between-5-6? 0)
;;(checked-is-between-5-6? "honolulu")

;; reply : symbol  ->  symbol
;; to determine a reply for the greeting s
(define (checked-reply s)
  (cond
  [(symbol? s) (reply s)]
  [else (error 'checked-reply "Symbol expected")]))

(define (reply s)
  (cond
    [(symbol=? s 'GoodMorning) 'Hi]
    [(symbol=? s 'HowAreYou?) 'Fine]
    [(symbol=? s 'GoodAfternoon) 'INeedANap]
    [(symbol=? s 'GoodEvening) 'BoyAmITired]
    [else (error 'reply "Unknown symbol")]))

;; TESTS
;;(checked-reply 'Hola)
(checked-reply 'GoodMorning)
;;(checked-reply "Marrakesh")

;; checked-distance-to-0 : posn -> ???
;; Checks distance-to-0 inputs
(define (checked-distance-to-0 a-posn)
  (cond
    [(posn? a-posn) (distance-to-0 a-posn)]
    [else (error 'checked-distance-to-0 "A position expected")]))

;; distance-to-0 : posn  ->  number
;; to compute the distance of a-posn to the origin 
(define (distance-to-0 a-posn)
  (sqrt
    (+ (sqr (posn-x a-posn))
       (sqr (posn-y a-posn)))))

;; TESTS
(checked-distance-to-0 (make-posn 3 4))
;;(checked-distance-to-0 "Onyon Rengs")
          	
;; Data Definitions:
(define-struct circle (center radius))
;; A circle is a structure:
;;          (make-circle p s)
;;    where p is a posn, s a number;

(define-struct square (nw length))
;; A square is a structure:
;;          (make-square p s)
;;    where p is a posn, s a number.

;; A shape is either
;; 1. a circle, or
;; 2. a square. 
;;
;; checked-perimeter : shape -> number
;; Checks perimeter function for correct input
(define (checked-perimeter a-shape)
  (cond
    [(or (circle? a-shape) (square? a-shape)) (perimeter a-shape)]
    [else (error 'checked-perimeter "Expects eithere a circle or a square")]
    ))

;; perimeter : shape  ->  number
;; to compute the perimeter of a-shape
(define (perimeter a-shape)
  (cond
    [(circle? a-shape)
     (* (* 2 (circle-radius a-shape)) pi)]
    [(square? a-shape)
     (* (square-length a-shape) 4)]))

;; TESTS
(checked-perimeter (make-circle (make-posn 3 2) 30))
(checked-perimeter (make-square (make-posn 3 2) 30))
;;(checked-perimeter "All the base are belong to us")
