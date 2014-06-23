;; quadratic-roots : number number number -> ???
;; Outputs the roots of a quadratic equation
(define (quadratic-roots a b c)
  (cond
    [(= a 0) 'degenerate]
    [(< (sqr b) (* 4 a c)) 'none]
    [(= (sqr b) (* 4 a c)) (/ (- b) (* 2 a))]
    [(> (sqr b) (* 4 a c)) (proper-roots a b c)]))

;; determinant : number number number -> number
;; Computes the determinant of a quadratic equation with coefficients
;; a, b and c
(define (discriminant a b c)
  (- (sqr b) (* 4 a c)))


;; proper-roots : number number number -> number
;; Returns the proper roots of a quadratic equation with coefficients
;; a,b and c
(define (proper-roots a b c)
  (cons 
    (/ (+ (- b) (sqrt (discriminant a b c))) (* 2 a)) 
    (cons (/ (- (- b) (sqrt (discriminant a b c))) (* 2 a)) empty)))

;; TESTS
;; contains-same? : list list -> boolean
;; Compares if two lists are the same.
(define (contains-same? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) true]
    [(or (empty? l1) (empty? l2)) false]
  [else (and (= (first l1) (first l2)) (contains-same? (rest l1) (rest l2)))]))

(define expected (cons 1 (cons -1 empty)))
(contains-same? (quadratic-roots 1 0 -1) expected)
(= (quadratic-roots 2 4 2) -1)
(symbol=? (quadratic-roots 0 0 1) 'degenerate)
(symbol=? (quadratic-roots 2 4 3) 'none)
