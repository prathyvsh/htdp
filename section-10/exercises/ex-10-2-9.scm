;; DATA DEFINITION
;; An inventory record consists of
;; (make-struct ir (symbol number))
(define-struct ir (name price))

;; An inventory is either
;; empty
;; or (cons ir inventory)
;; EXAMPLE
(define inv1 (cons (make-ir 'doll 10) (cons (make-ir 'robot 20) empty)))

#|
;; TEMPLATE
(define (name-robot toy-descriptions)
  (cond
    [(empty? toy-descriptions) ...]
    [... (first toy-descriptions) ... (name-robot (rest toy-descriptions))]
    ))
 |#

;; name-robot list-of-toy-descriptions -> list-of-toy-descriptions
;; Takes in a list of toy descriptions and replaces all occurences of 'robot with 'r2d2
(define (name-robot lotd)
  (cond
    [(empty? lotd) empty]
    [else
      (cond
       [(symbol=? (ir-name (first lotd)) 'robot)
        (cons (make-ir 'r2d3 (ir-price (first lotd)))
              (name-robot (rest lotd)))]
       [else (cons (first lotd) (name-robot (rest lotd)))])]))


;; substitute list-of-toy-descriptions symbol symbol ->
;; Takes in a list of toy descriptions lotd and replaces occurences of old
;; with new
(define (substitute old new lotd)
  (cond
    [(empty? lotd) empty]
    [else
      (cond
       [(symbol=? (ir-name (first lotd)) old)
        (cons (make-ir new (ir-price (first lotd)))
                       (substitute old new (rest lotd)))]
       [else (cons (first lotd) (substitute old new (rest lotd)))])]))

;; TESTS
(name-robot inv1)
"and"
(substitute 'robot 'r2d3 inv1)
"should be" (cons (make-ir 'doll 10) (cons (make-ir 'r2d3 20) empty))
