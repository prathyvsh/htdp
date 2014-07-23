#lang racket
(require lang/htdp-intermediate)

(define (a-function=? one-fn other-fn)
  (and
   (= (one-fn 1.2) (other-fn 1.2))
   (= (one-fn 3) (other-fn 3))
   (= (one-fn -5.7) (other-fn -5.7))))

;; TESTS
(define (fn1 v) 0)
(define (fn2 v) (+ v v))
      
(a-function=? fn1 fn1)
(a-function=? fn2 fn2)
(not (a-function=? fn1 fn2))

;; No it is not possible with what has been taught to check
;; if two functions produces the exact same value since we
;; would have to check their output on every single numbers.
;; But I suspect some kind of mathematical proofs like approach
;; could be deviced to solve this problem.
