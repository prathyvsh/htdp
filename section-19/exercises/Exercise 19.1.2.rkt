(filter1 > (cons 8 (cons 6 (cons 4 empty))) 5)


(cons 8 (filter1 > (cons 6 (cons 4 empty)) 5))
(cons 8 (cons 6 (filter1 > (cons 4 empty)) 5))
(cons 8 (cons 6 (filter1 > empty) 5))
(cons 8 (cons 6 empty))
