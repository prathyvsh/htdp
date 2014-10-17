#lang racket
(require lang/htdp-beginner)

(and (> 4 3) (<= 10 100))
;(and true true)
;true

(or (> 4 3) (= 10 100))
;(or true false)
;true

(not (= 2 3)) 
;(not false)
;true
