;; DATA DEFINITION
;; An inventory record consists of
;; (make-struct ir (symbol number))
(define-struct ir (name price))

;; extract1 : inventory  ->  inventory
;; To create an inventory from an-inv for all
;; those items that cost more than $1
(define (extract>1 an-inv)
  (cond
    [(empty? an-inv) empty]
    [else (cond
            [(> (ir-price (first an-inv)) 1.00)
             (cons (first an-inv) (extract1 (rest an-inv)))]
            [else (extract1 (rest an-inv))])]))

;; TEST
;; contains-same? : list list -> boolean
;; Compares if two lists are the same.
(define (contains-same-symbols? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) true]
    [(or (empty? l1) (empty? l2)) false]
  [else (and (symbol=? (first l1) (first l2))
             (contains-same-symbols? (rest l1) (rest l2)))]))

(contains-same? (extract>1 empty) empty)
(contains-same? (extract>1 (cons (make-ir 'doll .50) empty)) empty)
(extract>1 (cons (make-ir 'rocket 1.50 empty))) "should be" (cons (make-ir 'rocket 1.50) empty)
