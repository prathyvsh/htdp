#lang racket
(require lang/htdp-beginner)

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
       [(symbol=? (first lotd) 'robot)
        (cons 'r2d2 (name-robot (rest lotd)))]
       [else (cons (first lotd) (name-robot (rest lotd)))])]))


;; substitute list-of-toy-descriptions symbol symbol ->
;; Takes in a list of toy descriptions lotd and replaces occurences of old
;; with new
(define (substitute old new lotd)
  (cond
    [(empty? lotd) empty]
    [else
      (cond
       [(symbol=? (first lotd) old)
        (cons new (substitute old new (rest lotd)))]
       [else (cons (first lotd) (substitute old new (rest lotd)))])]))

;; TESTS
;; contains-same? : list list -> boolean
;; Compares if two lists are the same.
(define (contains-same-symbols? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) true]
    [(or (empty? l1) (empty? l2)) false]
  [else (and (symbol=? (first l1) (first l2)) (contains-same-symbols? (rest l1) (rest l2)))]))

(define expected-value (cons 'robot (cons 'Barbie (cons 'dress empty))))
(contains-same-symbols? (substitute 'doll 'Barbie (cons 'robot (cons 'doll (cons 'dress empty)))) expected-value)
