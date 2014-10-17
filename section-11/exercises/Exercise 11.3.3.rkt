#lang racket
(require lang/htdp-beginner)

#|
;;TEMPLATE
(define (create-temps n low high)
  (cond
    [(zero? n) ...]
    [... (create-temps (sub1 n)) ...]))
|#

;; create-temps natural-number integer integer -> list-of-integers
;; Consumer a natural number n and outputs a list of integers between
;; low and high
(define (create-temps n low high)
  (cond
    [(zero? n) empty]
    [else (cons (random-n-m low high) (create-temps (sub1 n) low high))]
    ))

;; random-n-m : integer integer -> integer
;; Creates a number between n and m
;; Assume n < m
(define (random-n-m n m)
  (+ (random (- m n)) n))


;; check-range? temperature-list number number -> boolean
;; Determines if all temperatures in temperature-list is between start
;; and end
(define (check-range? temperature-list start end)
  (cond
    [(empty? temperature-list) true]
    [else (and (between? start end (first temperature-list)) (check-range? (rest temperature-list) start end))]))

;; between : number number number -> boolean
;; Determines if point is between start and end both exclusive.
(define (between? start end point)
  (< start point end))

;; TESTS
(boolean=? (check-range? (create-temps 10 5 95) 5 95) true)
(boolean=? (check-range? (create-temps 10 96 100) 5 95) false)
(boolean=? (check-range? (create-temps 10 100 300) 5 95) false)
(boolean=? (check-range? (create-temps 10 20 50) 4 100) true)
(boolean=? (check-range? (create-temps 10 1 10) 10 30) false)
(boolean=? (check-range? (create-temps 10 1 10) 10 30) false)
(boolean=? (check-range? (create-temps 10 10 20) 4 30) true)

#|

;; QUESTIONS

Q: Can we simply feed the result of create-temps into check-range or do we need to know the list that create-temps produced? 
A: We can use create-temps as a test for check-range?, but we
 cannot simply feed it into check-range, we have to ensure that the
 range of create-temps is well within the range of check-range to
 produce a true result or well outside of the range of check-range
 for a false result. The result can only be reliably predicted
 In case there is a partial overlap in the either ends, the result
 cannot be predicted with given accuracy since the ranges may fall
 within the check-range sometimes and sometimes not since the numbers
 generated are random.

Q: Are there values for low and high such that we don't need to know the result of create-temps and yet we can predict the result of the test? 
A: Yes when the high = low + 1. The list would only contain the lower.

Q: Which function tests which?
A: Both functions test each other in this case.

Q: What does this tell us about testing with automatically generated test data?
A: Now since there is a coupling between both of the functions, automatically generated test data cannot reliably test a function since it relies on the other to test itself.
|#
