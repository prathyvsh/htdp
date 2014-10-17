#|
1. (+ (* (/ 12 8) 2/3)
	(- 20 (sqrt 4)))

(+ (* 3/2 2/3) (- 20 (sqrt 4)))
(+ 1 (- 20 (2)))
(+ 1 18)
19

2. (cond
       [(= 0 0) false]
       [(> 0 1) (symbol=? 'a 'a)]
       [else (= (/  1 0) 9)])

(cond
  [true false]
  [(> 0 1) (symbol=? 'a 'a)]
  [else (= (/  1 0) 9)])

false

3. (cond
       [(= 2 0) false]
       [(> 2 1) (symbol=? 'a 'a)]
       [else (= (/  1 2) 9)]) ;

(cond
  [false false]
  [true (symbol=? 'a 'a)]
  [else (= (/ 1 2) 9)])

(cond
  [true true]
  [else (= (/ 1 2) 9)])

true
|#
