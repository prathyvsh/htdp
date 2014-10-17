(cons 'a (cons 'b (cons 'c (cons 'd (cons 'e empty))))) "is same as"
(list 'a 'b 'c 'd 'e)

(cons (cons 1 (cons 2 empty)) empty) "is same as"
(list (list 'a 'b))

(cons 'a (cons (cons 1 empty) (cons false empty))) "is same as"
(list 'a (list 1) false)

(cons (cons 1 (cons 2 empty)) (cons (cons 2 (cons 3 empty)) empty)) "is same as"
(list (list 1 2) (list 2 3))
