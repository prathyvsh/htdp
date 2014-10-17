#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
(define (convert-euro list-of-dollars)
  (cond
    [(empty? list-of-dollars) empty]
    [... (first list-of-dollars) ... (convert-euro (rest list-of-dollars))]
    ))
|#
;; convert-euro : list-of-dollars -> list-of-euros
;; Converts a list of dollars to a list of equivalent euros at the rate of 1.22
(define (convert-euro list-of-dollars)
  (cond
    [(empty? list-of-dollars) empty]
    [else (cons
            (dollar->euro (first list-of-dollars))
            (convert-euro (rest list-of-dollars)))]
    ))

;; convert-euro-1 : list-of-dollars number -> list-of-euros
;; Converts a list of dollars to a list of equivalent euros at a given rate
(define (convert-euro-1 list-of-dollars rate)
  (cond
    [(empty? list-of-dollars) empty]
    [else (cons
            (dollar->euro-with-rate (first list-of-dollars) rate)
            (convert-euro-1 (rest list-of-dollars) rate))]
    ))

;dollar->euro: number -> number
;Converts dollar to euro
;Uses rates 1.22 as mentioned in the exercise
(define (dollar->euro dollar)
  (* dollar 1.22))

;dollar->euro: number -> number
;Converts dollar to euro
;Uses rates 1.22 as mentioned in the exercise
(define (dollar->euro-with-rate dollar rate)
  (* dollar rate))

;; contains-same? : list list -> boolean
;; Compares if two lists are the same.
(define (contains-same? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) true]
    [(or (empty? l1) (empty? l2)) false]
  [else (and (= (first l1) (first l2)) (contains-same? (rest l1) (rest l2)))]))

;; TESTS
(define dollars (cons 10 (cons 20 (cons 30 empty))))
(define euros (cons 12.2 (cons 24.4 (cons 36.6 empty))))

(contains-same? (convert-euro dollars) euros)
(contains-same? (convert-euro-1 dollars 1.22) euros)
