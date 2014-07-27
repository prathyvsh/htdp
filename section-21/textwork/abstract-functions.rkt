#lang racket
(require lang/htdp-intermediate)

;; reduce : X (X  Y  ->  Y) (listof Y)  ->  Y
(define (reduce base combine l)
  (cond
    [(empty? l) base]
    [else (combine (first l)
	    (reduce base combine (rest l)))]))

;; map using reduce
(define (map1 fn list)
  (local (
          (define (cons-by-apply x y)
            (cons (fn x) y)))
    (reduce empty cons-by-apply list)))

;; sort using reduce
(define (sort l)
  (local ((define (insert an alon)
	    (cond
	      [(empty? alon) (list an)]
	      [else (cond
		      [(> an (first alon)) (cons an alon)]
		      [else (cons (first alon) (insert an (rest alon)))])])))
    (reduce empty insert l)))

;; TESTS
(define (i x) x)
(define (f x) (* 2 x))
(equal? (map f (build-list1 8 i)) (map1 f (build-list1 8 i)))

;; filter : (X  ->  boolean) (listof X)  ->  (listof X)
;; to construct a list from all those items on alox for which p holds 
(define (filter p alox) ...)

;; assf : (X  ->  boolean) (listof (list X Y))  ->  (list X Y) or false
;; to find the first item on alop for whose first item p? holds
(define (assf p? alop) ...)
