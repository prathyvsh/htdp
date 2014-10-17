#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
(define-struct ir (name price))

;; EXAMPLE DATA
(define an-inv (cons (make-ir 'Barbie 0.25) (cons (make-ir 'Teddy 6.25) (cons (make-ir 'r2d2-Special-Edition 75) empty))))

;; FUNCTIONS
;; price-of : symbol inventory -> number or false
;; Consumes a toy-name and gives back it's price from the inventory
(define (price-of toy-name inventory)
  (cond
    [(empty? inventory) false]
    [else (cond
       [(symbol=? toy-name (ir-name (first inventory))) (ir-price (first inventory))]
       [else (price-of toy-name (rest inventory))])]))

;; TESTS
(= (price-of 'r2d2-Special-Edition an-inv) 75)
(= (price-of 'Teddy an-inv) 6.25)
