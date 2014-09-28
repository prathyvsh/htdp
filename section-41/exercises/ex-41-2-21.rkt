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


;; count-children : f-tree -> (vectorof number)
;; Counts the number of family members that have
;; 0, 1, 2, 3, 4, 5 or 5+ children.
(define (count-children ft)
  (local ((define report (build-vector 6 (lambda (i) 0))))
    (cond
     [(empty? ft) report]
     [else (count-children-aux report ft)])))

;; count-chidren-aux : (vectorof number) f-tree
;; Counts the number of family members a member has
(define (count-children-aux report ft)
  (begin (local ((define child-count (parent-no-descendants ft)))
    (cond
      [(< child-count 5) (vector-set! report child-count (add1 (vector-ref report child-count)))]
      [else (vector-set! report 5 (add1 (vector-ref report 5)))]))
         (count-each-children report (parent-children ft))))

;; count-each-children : (vectorof number) (listof children)
;; Counts the number of famil
(define (count-each-children report children)
  (cond
   [(empty? children) report]
   [else (begin (count-children-aux report (first children))
         (count-each-children report (rest children)))]))

;; TESTS

;; Fifth Generation
(define Tom (make-parent empty 'Tom 18 'grey 0))

;; Fourth Generation
(define Bob&Martha (list Tom))
(define Bob (make-parent Bob&Martha 'Bob 33 'green 0))
(define Martha (make-parent Bob&Martha 'Martha 21 'blue 0))

(define August (make-parent empty 'August 23 'green 0))
(define Ben (make-parent empty 'Ben 24 'brown 0))
(define George (make-parent empty 'George 42 'blue 0))

;; Third Generation
(define Judith (make-parent (list Ben) 'Judith 33 'green 0))
(define James (make-parent (list Ben Bob) 'James 23 'blue 0))

(define Tony&Betty (list George))
(define Tony (make-parent Tony&Betty 'Tony 23 'black 0))
(define Betty (make-parent Tony&Betty 'Betty 31 'green 0))

;; Second Generation
(define Jenna&Malcolm (list James))
(define Jenna (make-parent Jenna&Malcolm 'Jenna 33 'grey 0))
(define Malcom (make-parent Jenna&Malcolm 'Malcom 42 'brown 0))

(define Joseph&Rose (list Tony))
(define Joseph (make-parent Joseph&Rose 'Joseph 29 'yellow 0))
(define Rose (make-parent Joseph&Rose 'Rose 22 'grey 0))

;; First Generation
(define Tina&Fred (list Jenna Rose))
(define Fred (make-parent Tina&Fred 'Fred 19 'brown 0))
(define Tina (make-parent Tina&Fred 'Martha 24 'blue 0))

(begin (ft-descendants Tina)
(equal? (count-children Tina) (vector 3 2 1 1 1 1)))
(begin (ft-descendants Joseph)
(equal? (count-children Joseph) (vector 1 1 1 0 0 0)))
