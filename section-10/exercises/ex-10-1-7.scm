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
     [(symbol=? (first lon) ty) (recall ty (rest lon))]
     [else (cons (first lon) (recall ty (rest lon)))])]
    ))


;; TESTS
;; contains-same? : list list -> boolean
;; Compares if two lists are the same.
(define (contains-same-symbols? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) true]
    [(or (empty? l1) (empty? l2)) false]
  [else (and (symbol=? (first l1) (first l2)) (contains-same-symbols? (rest l1) (rest l2)))]))

(define expected-value (cons 'doll (cons 'dress empty)))

(contains-same-symbols? (recall 'robot (cons 'robot (cons 'doll (cons 'dress empty)))) expected-value)
(contains-same-symbols? (recall empty) empty)
