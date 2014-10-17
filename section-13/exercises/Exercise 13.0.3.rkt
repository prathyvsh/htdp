(list 0 1 2 3 4 5) "is same as"
(cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 empty))))))

(list (list 'adam 0) (list 'eve 1) (list 'louisXIV 2)) "is same as"
(cons (cons 'adam (cons 0 empty)) (cons (cons 'eve (cons 1 empty)) (cons (cons 'louisXIV (cons 2 empty)) empty)))

(list 1 (list 1 2) (list 1 2 3)) "is same as"
(cons 1 (cons (cons 1 (cons 2 empty)) (cons (cons 1 (cons 2 (cons 3 empty))) empty)))

