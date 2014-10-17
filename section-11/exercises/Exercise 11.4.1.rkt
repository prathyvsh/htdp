#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (! n)
  (cond
    [(zero? n) ...]
    [else ... (! (sub1 n)) ... ]))
|#

;; ! : N  ->  N
;; to compute n  ·  (n - 1)  ·  ...  ·  2  ·  1
(define (! n)
  (cond
    [(zero? n) 1]
    [else (* n (! (sub1 n))) ]))

#|
 |
;; HAND EVALUATION
(! 2) =
  (cond
    [(zero? 2) 1]
    [else (* 2 (! (sub1 2)))])

(cond
  [false 1]
  [else (* 2 (! (sub1 2)))])

(* 2 (! (sub1 2)))

(* 2 (! 1))

(* 2 (cond
      [(zero? 1) 1]
      [else (* 1 (sub1 1))]))

(* 2 (cond
       [false 1]
       [else (* 1 (sub1 1))]))

(* 2 (* 1 (sub1 1)))

(* 2 (* 1 
        (cond
          [(zero? 0) 1]
          [else (* 0 (sub1 0))])))

(* 2 (* 1 (cond
            [true 1]
            [else (* 0 (sub1 0))])))

(* 2 (* 1 1)) 

2
|#

;; TESTS
(! 10)
(! 100)
(! 1000)
