;; DATA DEFINITION
(define-struct ir (name price))
;; an inventory record is
;; (make-ir symbol number picture)

#|
;; TEMPLATE
(define (contains-doll? an-inv)
  (cond
    [(empty? an-inv) ...]
    [else (ir-name (first an-inv)) ... (ir-price (first an-inv)) ... (contains-doll? (rest an-inv))]))

#|
;; contains-doll? : inventory  ->  boolean
;; to determine whether an-inv contains a record for 'doll
(define (contains-doll? an-inv)
  (cond
    [(empty? an-inv) false]
    [else (or (symbol=? '(ir-name (first an-inv)) 'doll)) (contains-doll? (rest an-inv))]))

;; contains? : symbol inventory -> boolean
;; to determine whether inventory contains a record for asymbol
(define (contains? asymbol an-inv)
  (cond
    [(empty? an-inv) false]
    [else (or (symbol=? '(ir-name (first an-inv)) asymbol)) (contains-doll? asymbol (rest an-inv))]))

;; TESTS

