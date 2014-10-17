#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
;; An inventory record consists of
;; (make-struct ir (symbol number))
(define-struct ir (name price))

;; An inventory is either
;; empty
;; or (cons ir inventory)
;; EXAMPLE
(define inv1 (cons (make-ir 'Doll 10) (cons (make-ir 'Robot 20) empty)))

;; raise-prices : inventory -> inventory
;; Raises the prices in an-inv by 5%
(define (raise-prices an-inv)
  (cond
    [(empty? an-inv) empty]
    [else (cons (raise-by-5 (first an-inv))
                (raise-prices (rest an-inv)))]))

;; raise-record-price-by-5 : inventory-record -> inventory-record
;; Raises a given inv-rec's price by 5%
(define (raise-record-price-by-5  inv-rec)
  (make-ir (ir-name inv-rec) (raise-by 5 (ir-price inv-rec)))

;; raise-by : number number -> number
;; Raises the given value by given percentage.
(define (raise-by percentage value)
  (+ value (* (/ percentage 100) value)))

;; TESTS
(raise-prices empty) "should be" empty
(raise-prices inv1) "should be" (cons (make-ir 'Doll 10.5) (cons (make-ir 'Robot 21) empty))

