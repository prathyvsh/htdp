#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
(define (convertFC fhts)
  (cond
    [(empty? fht) ...]
    [... (first fhts) ... (convertFC (rest fhts))]))
|#
;; convertFC : list-of-temps -> list-of-temps
;; Takes in a list of temperatures measured in fahrenheit and converts
;; it to celsius
(define (convertFC fhts)
  (cond
  [(empty? fhts) empty]
  [else (cons (F->C (first fhts)) (convertFC (rest fhts)))]))


;; F->C number -> number
;; Takes in a fahrenheit temperature and outputs a temperature in
;; celsius
(define (F->C fht)
  (* (/ 5 9) (- fht 32)))

;; TESTS
(define fahrenheits (cons 32 (cons 212 empty)))
(define celsiuses (cons 0 (cons 100 empty))) 

;; contains-same : list list -> boolean
;; Compares if two lists are the same.
(define (contains-same? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) true]
    [(or (empty? l1) (empty? l2)) false]
  [else (and (= (first l1) (first l2)) (contains-same? (rest l1) (rest l2)))]))


(contains-same? (convertFC fahrenheits) celsiuses)
