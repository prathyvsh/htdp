#lang racket
(require lang/htdp-beginner-abbr)

#|
;; Data Definition:
A binary-tree is either
  1. false or
  2. (make-node n left right)
     where n is a number and lft and rgt are BTs
|#
(define-struct bt (id left right))

;; tree=? binary-tree binary-tree
(define (tree=? a-bt another-bt)
  (cond
   [(false? a-bt) (false? another-bt)]
   [else (and (= (bt-id a-bt) (bt-id another-bt))
          (and (tree=? (bt-left a-bt) (bt-left another-bt))
         (tree=? (bt-right a-bt) (bt-right another-bt))))]))

;; TESTS
(tree=? false false)
(define tree3 (make-bt 3 false false))
(define tree4 (make-bt 4 false false))
(not (tree=? tree3 tree4))

(define tree35 (make-bt 5 tree3 false))
(define tree45 (make-bt 5 tree4 false))
(not (tree=? tree35 tree45))

(tree=? tree35 tree35)
