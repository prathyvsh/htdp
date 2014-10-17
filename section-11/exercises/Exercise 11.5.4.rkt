#lang racket
(require lang/htdp-beginner)

;; REPRESENTATION

;; 0
(define zero empty)

;; 3
(define three (cons (cons (cons 'natural-number empty) empty) empty))

;; 8
(define eight (cons (cons (cons (cons (cons (cons (cons (cons 'natural-number empty) empty) empty) empty) empty) empty) empty) empty))

;; depth : deep-list -> number
;; Computes the depth of a given deep list
(define (depth dl)
  (cond
    [(symbol? dl) 0]
    [else (add1 (depth (first dl)))]))

;; make-deep : symbol number -> deep-list
;; Creates a deep list with a-symbol of given depth
(define (make-deep symbol depth)
  (cond
    [(zero? depth) symbol]
    [else (cons (make-deep symbol (sub1 depth)) empty)]))

;; addDL : deep-list deep-list -> deep-list
;; Adds the depth of two deep-lists and provides a new deep-list with
;; resultant sum
(define (addDL list1 list2)
  (make-deep 'natural-number (+ (depth list1) (depth list2))))

;; TESTS
(addDL three eight) "should be"
(cons (cons (cons (cons (cons (cons (cons (cons (cons (cons (cons 'natural-number empty) empty) empty) empty) empty) empty) empty) empty) empty) empty) empty)
