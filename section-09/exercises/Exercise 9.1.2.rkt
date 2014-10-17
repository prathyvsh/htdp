#lang racket
(require lang/htdp-beginner)

(cons 10 (cons 20 (cons 5 empty)))

(rest l)
(rest (cons 10 (cons 20 (cons 5 empty))))
(cons 20 (cons 5 empty))

(first (rest l))
(first (cons 20 (cons 5 empty)))
20

(rest (rest l))
(rest (cons 20 (cons 5 empty)))
(cons 5 empty)

(first (rest (rest l)))
(first (cons 5 empty))
5

(rest (rest (rest l))) 
(rest (cons 5 empty))
empty
