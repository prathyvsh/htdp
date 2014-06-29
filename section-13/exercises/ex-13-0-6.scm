(list (symbol=? 'a 'b) (symbol=? 'c 'c) false)
(list false true false)
(cons false (cons true (cons false empty)))

(list (+ 10 20) (* 10 20) (/ 10 20))
(list 30 200 0.5)
(cons 30 (cons 200 (cons 0.5 empty)))

(list 'dana 'jane 'mary 'laura)
(cons 'dana (cons 'jane (cons 'mary (cons 'laura empty))))
