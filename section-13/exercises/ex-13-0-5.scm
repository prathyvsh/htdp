(cons 'a (list 0 false)) "is same as"
(cons 'a (cons 0 (cons false empty)))

(list (cons 1 (cons 13 empty))) "is same as"
(cons (cons 1 (cons 13 empty)) empty)

(list empty empty (cons 1 empty)) "is same as"
(cons empty (cons empty (cons (cons 1 empty) empty)))

(cons 'a (cons (list 1) (list false empty))) "is same as"
(cons 'a (cons (cons 1 empty) (cons false (cons empty empty))))
