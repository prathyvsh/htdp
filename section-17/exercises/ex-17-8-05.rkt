#|
;; An atom is either
1. a number
2. a boolean
3. a symbol
|#

#lang racket
(require lang/htdp-beginner-abbr)

;; list-equal? : list-of-atoms list-of-atoms
;; Determines if both lists are equal.
(define (list-equal? a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [(cons? a-list) 
     (and (cons? another-list)
          (and (atom-equal? (first a-list) (first another-list))
               (list-equal? (rest a-list) (rest another-list))))]))

;; atom-equal? : atom atom -> boolean
;; Determines if both atoms are equal
(define (atom-equal? an-atom other-atom)
  (cond
  [(and (number? an-atom) (number? other-atom))
   (= an-atom other-atom)]
  [(and (boolean? an-atom) (boolean? other-atom))
   (boolean=? an-atom other-atom)]
  [(and (symbol? an-atom) (symbol? other-atom))
        (symbol=? an-atom other-atom)]
  [else (error 'atom-equal? "Unknown atom provided")]))

;; Tests

;; atom-equal? tests
(not (atom-equal? 5 3))
(atom-equal? 5 5)
 (atom-equal? true true)
(not (atom-equal? true false))
(atom-equal? 'simba 'simba)
(not (atom-equal? 'timon 'pumba))

;; list-equal? tests
(not (list-equal? (list 3 4 5) (list 5 3 4)))
(list-equal? (list 'jurassic) (list 'jurassic))
(list-equal? (list 'whatever 'works) (list 'whatever 'works))
(not (list-equal? (list true true true) (list true true true false)))
