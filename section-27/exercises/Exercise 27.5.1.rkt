#lang racket
(require lang/htdp-intermediate-lambda)

;; equation? : number number number number number number number -> boolean
;; Determines if an equation ax + by + cz is equivalent to rhs
(define (equation? x y z a b c rhs)
  (= (+ (* a x) (* b y) (* c z)) rhs))

(equation? 1 1 2 2 2 3 10)
(equation? 1 1 2 0 3 9 21)
(equation? 1 1 2 0 -3 -8 -19)
  
