#lang racket
(require lang/htdp-beginner-abbr)

#|
A Slist is either:
1. empty
2. (cons s sl) where s is a Sexpr and sl is a Slist

A Sexpr is either:
1. a number
2. a boolean
3. a symbol
4. a Slist
|#

;; DATA EXAMPLES
(define sexpr1 3)
(define sexpr2 true)
(define sexpr3 'test)
(define Slist1 (cons sexpr1 (cons sexpr2 empty)))
(define sexpr4 Slist1)
(define sexpr5 true)
(define sexpr6 'mango)
(define Slist2 (cons sexpr5 (cons sexpr6 empty)))


;; atom? Sexpr -> boolean
;; Determines if the Sexpr is an atom that is
;; if it is either a symbol number or boolean
(define (atom? el)
 (or (symbol? el) (number? el) (boolean? el)))

;; TESTS
(and (atom? 'test) (atom? 3) (atom? true))

;; atom=? atom atom -> boolean?
;; Determines if an atom is equal to another
(define (atom=? an-atom other-atom)
  (cond
  [(and (number? an-atom) (number? other-atom))
   (= an-atom other-atom)]
  [(and (boolean? an-atom) (boolean? other-atom))
   (boolean=? an-atom other-atom)]
  [(and (symbol? an-atom) (symbol? other-atom))
        (symbol=? an-atom other-atom)]
  [else (error 'atom-equal? "Unknown atom provided")]))


;; Slist=? : Slist Slist -> boolean
;; Determines if both the Slists contain the same items at analogous positions
(define (Slist=? a-list another-list)
  (cond
   [(empty? a-list) (empty? another-list)]
   [(atom? (first a-list))
    (and (atom? (first another-list))
         (atom=? (first a-list) (first another-list))
         (Slist=? (rest a-list) (rest another-list)))]
   [else (and (Sexpr=? (first a-list) (first another-list))
              (Slist=? (rest a-list) (rest another-list)))]))

;; TESTS
(not (Slist=? (list 3) (list 4)))
(Slist=? (list 3) (list 3))
(Slist=? (list 3 4) (list 3 4))
(not (Slist=? (list 3 4) (list 3 4 5)))
(not (Slist=? (list true) (list false)))
(Slist=? (list true true false)
         (list true true false))
(not (Slist=? (list true false true) (list true true)))
(Slist=? (list 'mango 'apple 'lemon) (list 'mango 'apple 'lemon))

#|
TEMPLATE for Sexpr
(define (sexpr-fun expr1 expr2)
  [(empty? expr1) ... expr2 ...]
  [(atom? expr1) ... expr2 ...]
  [else (Slist-fun expr1 expr2)])
|#

;; Sexpr=? : expr expr -> boolean
;; Determines if both the expressions are of same value          
(define (Sexpr=? expr other-expr)
  (cond
  [(atom? expr) (and (atom? other-expr) (atom=? expr other-expr))]
  [else (Slist=? expr other-expr)]))
