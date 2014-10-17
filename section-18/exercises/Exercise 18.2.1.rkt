;; Bound Occurences of x
(define (p1 x y) (+ (* "x" y) (+ (* 2 "x") (+ (* 2 y) 22))))
(define (p2 x) (+ (* 55 x) (+ x 11)))
(define (p3 x) (+ (p1 x 0) (+ (p1 x 1) (p2 x))))

;; Bound Occurences of p1
(define (p1 x y) (+ (* x y) (+ (* 2 x) (+ (* 2 y) 22))))
(define (p2 x) (+ (* 55 x) (+ x 11)))
(define (p3 x) (+ ("p1" x 0) (+ ("p1" x 1) (p2 x))))

;; Renaming parameter x of p1 to a
(define (p1 a y) (+ (* a y) (+ (* 2 a) (+ (* 2 y) 22))))
(define (p2 x) (+ (* 55 x) (+ x 11)))
(define (p3 x) (+ (p1 x 0) (+ (p1 x 1) (p2 x))))

;; Renaming parameter x of p3 to b
(define (p1 a y) (+ (* a y) (+ (* 2 a) (+ (* 2 y) 22))))
(define (p2 x) (+ (* 55 x) (+ x 11)))
(define (p3 b) (+ (p1 b 0) (+ (p1 b 1) (p2 b))))
