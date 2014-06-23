;; DATA DEFINITION
;; An inventory record consists of
;; (make-struct ir (symbol number))
(define-struct ir (name price))

;; An inventory is either
;; empty
;; or (cons ir inventory)
;; EXAMPLE
(define inv1 (cons (make-ir 'Doll 10) (cons (make-ir 'Robot 20) empty)))

#|
;; TEMPLATE
(define (recall lon ty)
  (cond
    [(empty? lon) ...]
    [... (first lon) ... (rest lon) ...]
    ))
|#

;; recall : symbol list-of-toy-names -> list-of-toy-names
;; Eliminates given toy name ty from list-of-names lon
(define (recall ty lon)
  (cond
    [(empty? lon) empty]
    [else (cond
     [(symbol=? (ir-name (first lon)) ty) (recall ty (rest lon))]
     [else (cons
             (make-ir (ir-name (first lon)) (ir-price (first lon)))
             (recall ty (rest lon)))])]
    ))


;; TESTS
(recall 'ken (cons (make-ir 'robot 20)
                   (cons (make-ir 'ken 10)
                         (cons (make-ir 'doll 12)
                               (cons (make-ir 'dress 12) empty))))) "should be"
(cons (make-ir 'robot 20) (cons (make-ir 'doll 12) (cons (make-ir 'dress 12) empty)))
(recall 'anything empty) "should be" empty
