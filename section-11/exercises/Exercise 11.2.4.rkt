#lang racket
(require lang/htdp-beginner)

;; A deep-list is either
;; s where s is a symbol or
;; (cons dl empty), where dl is a deep list

#|
;; TEMPLATE
(define (deep-list-program dl)
  (cond
    [(symbol? dl) ...]
    [... (first dl) ... (rest dl) ...]))
|#

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

;; TESTS
(define turtles-2 (cons (cons 'turtle empty) empty))
(define turtles-5 (cons (cons (cons (cons (cons 'turtle empty) empty) empty) empty) empty))
(define linear-list (cons 'doll (cons 'barbie (cons 'ken empty))))

(= (depth turtles-2) 2)
(= (depth turtles-5) 5)
(= (depth linear-list) 1)
(depth empty)

(make-deep 'turtle 2) "should be" turtles-2
(make-deep 'turtle 5) "should be" turtles-5
(make-deep 'anything 0) "should be" empty
