#lang racket
(require lang/htdp-beginner)

;; DATA-DEFINITION
;; a word is either
;; empty or
;; (cons symbol word)

;; EXAMPLE
#|
empty
(cons 'a empty)
(cons 'b (cons 'a empty))
(cons 'b (cons 'a (cons 't empty)))
|#

;; a list-of-word is either
;; (cons word empty) or
;; (cons word list-of-word)

(define empty-word-list empty)
(define c-list (cons (cons 'c empty) empty))
(define bc-list (cons (cons 'b (cons 'c empty)) empty))
(define abc-list (cons (cons 'a (cons 'b (cons 'c empty))) empty))
(define bc-cb-list (cons (cons 'c (cons 'b empty))
                        (cons (cons 'b (cons 'c empty)) empty)))
(define alt-bc-cb-list (cons (cons 'c (cons 'b empty)) bc-list))
