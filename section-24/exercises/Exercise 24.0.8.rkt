#|
(lambda (x y)
  (+ x (* x y)))
|#

;; Binding occurences
(lambda ("x" y)
  (+ "x" (* "x" y)))

#|
(lambda (x y)
  (+ x
     (local ((define x (* y y)))
       (+ (* 3 x)
	  (/ 1 x)))))
|#

;; Binding occurences
(lambda ("x" y)
  (+ "x"
     (local ((define x (* y y)))
       (+ (* 3 x)
	  (/ 1 x)))))

#|
(lambda (x y)
  (+ x
     (local ((define "x" (* y y)))
       (+ (* 3 "x")
	  (/ 1 "x")))))
|#

(lambda (x y)
  (+ x
     ((lambda (x)
	(+ (* 3 x)
	   (/ 1 x)))
      (* y y))))

;; Binding occurences
(lambda ("x" y)
  (+ "x"
     ((lambda (x)
	(+ (* 3 x)
	   (/ 1 x)))
      (* y y))))

(lambda (x y)
  (+ x
     ((lambda ("x")
	(+ (* 3 "x")
	   (/ 1 "x")))
      (* y y))))
