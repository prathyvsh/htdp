#lang racket
(require lang/htdp-advanced)

(define-struct child (name social father mother))

;; A family-tree-node (short: ftn) is either
;; false, or
;; (make-child name socsec f m) where name is a symbol, socsec is a number, and f and m are ftns.

;; add-ftn! : a-ft number symbol child -> void
;; Effect : Modify the father field to contain the given child structure or mother structure according to the symbol passed in
(define (add-ftn! ft ssc anc child)
  (cond
   [(empty? ft) (void)]
   [(= ssc (child-social ft)) (cond
   [(symbol=? anc 'father) (set-child-father! ft child)]
   [(symbol=? anc 'mother) (set-child-mother! ft child)]
   [else (error 'add-ftn! "Unknown ancestor kind")])]
   [else (begin (add-ftn! (child-father ft) ssc anc child)
                (add-ftn! (child-mother ft) ssc anc child))]))

;; add-ftn! : a-ft number symbol child -> void
;; Effect : Modify the father field to contain the given child structure or mother structure according to the symbol passed in
(define (add-ftn1! ft ssc child mutator)
  (cond
   [(empty? ft) (void)]
   [(= ssc (child-social ft)) (mutator ft child)]
   [else (begin (add-ftn1! (child-father ft) ssc child mutator)
                (add-ftn1! (child-mother ft) ssc child mutator))]))
;; TESTS
(define john (make-child 'John 2382 empty empty))
(define davidoff (make-child 'Davidoff 0823 empty empty))
(define maria (make-child 'Maria 0992 empty empty))
(add-ftn! john 2382 'father davidoff)
(add-ftn! john 2382 'mother maria)

(equal? john (make-child 'John 2382 davidoff maria))
(define thomas (make-child 'Thomas 0012 empty empty))

(add-ftn! john 0823 'father thomas)
(equal? john (make-child 'John 2382 (make-child 'Davidoff 0823 thomas empty) maria))

(set! john (make-child 'John 2382 empty empty))
(add-ftn1! john 2382 davidoff set-child-father!)
(add-ftn1! john 2382 maria set-child-mother!)
(equal? john (make-child 'John 2382 davidoff maria))

(add-ftn1! john 0823 thomas set-child-father!)
(equal? john (make-child 'John 2382 (make-child 'Davidoff 0823 thomas empty) maria))
