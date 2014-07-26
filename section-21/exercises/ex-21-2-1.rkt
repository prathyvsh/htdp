#lang racket
(require lang/htdp-beginner)

;; (list 0 ... 3)
(define (f x) x)
(equal? (build-list 4 f) (list 0 1 2 3))

;; (List 1 ... 4)
(define (increment x) (+ x 1))
(equal? (build-list 4 increment) (list 1 2 3 4))

;; (list .1 .01 .001 .0001)
(define (h x) (/ 1 (expt 10 (increment x))))
(equal? (build-list 4 h) (list 1/10 1/100 1/1000 1/10000))


;; evens : N -> (listof N)
;; Creates the first n even numbers
(define (evens n)
  (local ((define (times2 x) (* 2 x)))
    (build-list n times2)))

;; TESTS
(equal? (evens 0) empty)
(equal? (evens 3) (list 0 2 4))


;; tabulate : fn number -> (listof number)
(define (tabulate fn n)
  (reverse1 (build-list (+ n 1) fn)))

(define (reverse1 alon)
  (cond
   [(empty? alon) empty]
   [else (append (reverse (rest alon)) (list (first alon)))]))

(equal? (tabulate sqrt 3) (list (sqrt 3) (sqrt 2) (sqrt 1) (sqrt 0)))


;; diagonal : n -> (listof (listof n))
(define (diagonal n)
  (define (toggled-list row)
    (local ((define col-num n)
            (define (toggle col) (cond [(= row col) 1] [else 0])))
      (build-list col-num toggle)))
    (build-list n toggled-list))

(diagonal 3)


