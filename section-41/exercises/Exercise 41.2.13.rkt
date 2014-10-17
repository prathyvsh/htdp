#lang racket
(require lang/htdp-advanced)

;; A parent is a structure:
;;  (make-parent loc n e) 
;; where loc is a list of children, n and e are symbols.
;;
;; A list-of-children is either
;; empty or
;; (cons p loc) where p is a parent and loc is a list of children.
(define-struct parent (children name date eyes no-descendants))

;; ft-descendants : parent -> number
;; Counts the number of descandants of parent excluding the parent.
(define (ft-descendants parent)
  (begin (set-parent-no-descendants! parent (ft-child-descendants (parent-children parent)))
         (parent-no-descendants parent)))

;; ft-child-descendants: list-of-children -> number
;; Counts the number of descendants in the child list excluding the parent.
(define (ft-child-descendants loc)
  (cond
    [(empty? loc) 0]
    [else (+ (ft-descendants (first loc)) (+ 1 (ft-child-descendants (rest loc))))]))

;; TESTS

(define August (make-parent empty 'August 23 'green 0))
(define Bob (make-parent empty 'Bob 33 'green 0))
(define Ben (make-parent empty 'Ben 24 'brown 0))
(define George (make-parent empty 'George 42 'blue 0))
(define Tony (make-parent (list George) 'Tony 23 'black 0))
(define Rose (make-parent (list Tony) 'Rose 22 'grey 0))
(define James (make-parent (list Ben Bob) 'James 23 'blue 0))
(define Jenna (make-parent (list James) 'Jenna 33 'grey 0))
(define Malcom (make-parent (list James) 'Malcom 42 'brown 0))
(define Fred (make-parent (list Jenna Rose) 'Fred 19 'brown 0))
(define Tina (make-parent (list Rose Jenna) 'Martha 24 'blue 0))
(define Joseph (make-parent (list Tony) 'Joseph 29 'yellow 0))
(define Betty (make-parent (list George) 'Betty 31 'green 0))
(define Judith (make-parent (list Ben) 'Judith 33 'green 0))

(= (ft-descendants George) 0)
(= (ft-descendants Tony) 1)
(= (ft-descendants Betty) 1)
(= (ft-descendants Joseph) 2)
(= (ft-descendants Rose) 2)
(= (ft-descendants Fred) 7)
(= (ft-descendants Tina) 7)
(= (ft-descendants Jenna) 3)
