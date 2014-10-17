
(define x 1)
(define y 1)
(begin (set! x (+ x 1))
       (set! y (- y 1))
       (* x y))

Here we have to wait for the
evaluation of x first and then
for the evaluation of y. Hence
the program consists of 4 parts,
2 each before and after of evaluation
of x and y.

(define a 5)
(* (+ a 1) (- a 1))
Here we don't have to wait
for anything and order of addition
and subtraction doesn't matter, both
return predicable results.
