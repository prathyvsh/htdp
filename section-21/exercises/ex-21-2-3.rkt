#lang racket
(require lang/htdp-intermediate)

;; DATA DEFINITION
(define-struct ir (name price))

;; eliminate-exp : number (listof IR) -> (listof IR)
;; Creates a list of all toys whose price is below ua
(define (eliminate-exp ua toy-list)
  (local ((define (price-filter x) (< (ir-price x) ua)))
    (filter price-filter toy-list)))

;; recall : ty (listof IR) -> (listof IR)
(define (recall name toy-list)
  (local ((define (not-name x) (not (symbol=? (ir-name x) name))))
    (filter not-name toy-list)))

;; selection : (listof toys) (listof toys) -> (listof toys)
(define (selection selected toy-names)
  (local ((define (is-present x) (contains? x selected)))
    (filter is-present toy-names)))

;; contains? : (list-of names) (listof names)
;; Checks if value is present in list
(define (contains? value list)
  (cond
   [(empty? list) false]
   [else (or (symbol=? value (first list))
             (contains? value (rest list)))]))


;; TESTS
(define toys (list (make-ir 'Doll 1.99) (make-ir 'Ken 30.99) (make-ir 'Barbie 14.99) (make-ir 'Robot 8.99)))

(equal? (eliminate-exp 10 toys) (list (make-ir 'Doll 1.99)
                                      (make-ir 'Robot 8.99)))

(equal? (recall 'Ken toys) (list (make-ir 'Doll 1.99)
                                 (make-ir 'Barbie 14.99)
                                 (make-ir 'Robot 8.99)))

(contains? 'Doll (list 'Doll 'Ken))
(equal? (selection (list 'Doll 'Ken 'Barbie) (list 'Doll 'Robot 'Dinosaur 'Barbie 'Ken 'Doll))
        (list 'Doll 'Barbie 'Ken 'Doll))
