#lang racket
(require lang/htdp-intermediate)

;; DATA DEFINITION
(define-struct ir (description price))

;; extract1 : inventory  ->  inventory
;; to create an inventory from an-inv for all
;; those items that cost less than $1
(define (extract1 an-inv)
  (cond
   [(empty? an-inv) empty]
   [else
    (local ((define first-element (first an-inv))
            (define extracted-rest (extract1 (rest an-inv))))
      (cond
       [(<= (ir-price first-element) 1.00)
        (cons first-element extracted-rest)]
       [else extracted-rest]))]))

;; DATA
(define cheap-balloon (make-ir 'balloon 0.50))
(define expensive-balloon (make-ir 'balloon 2.50))


;; TESTS
(equal? (extract1 empty) empty)
(equal? (extract1 (list cheap-balloon)) (list cheap-balloon))
(equal? (extract1 (list cheap-balloon expensive-balloon)) (list cheap-balloon))
