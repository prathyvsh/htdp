#|
Q1. ((lambda (x y)
(+ x (* x y)))
1 2)

(local ((define (expression x y)
          (+ x (* x y)))) 1 2)

(+ 1 (* 1 2))
(+ 1 2)
3
|#

#|
Q2. ((lambda (x y)
(+ x
   (local ((define x (* y y)))
     (+ (* 3 x)
        (/ 1 x)))))
1 2)

(local ((define (expression x y)
          (+ x (local ((define x (* y y)))
                 (+ (* 3 x) (/ 1 x)))))) 1 2)

(+ 1 (local ((define x (* 2 2))
             (+ (* 3 x) (/ 1 x))))))

(+ 1 (+ (* 3 4) (/ 1 4))))
(+ 1 (+ 12 1/4))
(+ 1 49/4)
53/4
|#

#|
Q3. ((lambda (x y)
(+ x
   ((lambda (x)
      (+ (* 3 x)
         (/ 1 x)))
    (* y y))))
1 2)

((lambda (x y)
   (+ x
      (local ((define x (* y y)))
	(+ (* 3 x)
	   (/ 1 x)))))
 1 2) = Q2 = 53/4
|#
