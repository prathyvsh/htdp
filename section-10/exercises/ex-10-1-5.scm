#|
;; TEMPLATE
(define (eliminate-exp list-of-prices ua)
  (cond
    [(empty? list-of-prices) ...]
    [... (first list-of-prices) ... (eliminate-exp (rest list-of-prices))]
    ))
 |#

;; eliminate-exp : list-of-prices number -> list-of-prices
;; Takes in a list-of-price lotp and eliminates expensive toys that are above value of ua.
(define (eliminate-exp ua lotp)
  (cond
    [(empty? lotp) empty]
    [else
      (cond
        [(<= (first lotp) ua) (cons (first lotp) (eliminate-exp ua (rest lotp)))]
        [else (eliminate-exp ua (rest lotp))]
        )]))

;; TESTS
;; contains-same? : list list -> boolean
;; Compares if two lists are the same.
(define (contains-same? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) true]
    [(or (empty? l1) (empty? l2)) false]
  [else (and (= (first l1) (first l2)) (contains-same? (rest l1) (rest l2)))]))

(define result (cons .95 (cons 1.0 empty)))

(contains-same (eliminate-exp 1.0 empty) empty)
(contains-same? (eliminate-exp 1.0 (cons 2.95 (cons .95 (cons 1.0 (cons 5 empty))))) result)
