1. (local ((define (x y) (* 3 y))) (* (x 2) 5))

(local ((define (x y) (* 3 y)) (* (x 2) 5)))

(define (x1 y) (* 3 y))
(* (x1 2) 5)

(* (* 3 2) 5)
(* 6 5)
30

2. (local ((define (f c) (+ (* 9/5 c) 32))) (- (f 0) (f 10)))

(define (f1 c) (+ (* 9/5 c) 32))
(- (f1 0) (f 10))
(- (+ (* 9/5 0) 32) (+ (* 9/5 10) 32))
(- 32 (+ 18 32))
-18

3. (local ((define (odd? n) (cond
                [(zero? n) false]
[else (even? (sub1 n))])) (define (even? n)
(cond
[(zero? n) true]
[else (odd? (sub1 n))])))
(even? 1))

(define(odd?1 n) (cond
                  [(zero? n) false]
                  [else (even1? (sub1 n))]))
(define (even?1 n) (cond
                    [(zero? n) true]
                    [else (odd1? (sub1 n))]))
(even1? 1)

(cond
 [(zero? 1) true]
 [else (odd1? (sub1 1))])

(odd1? (sub1 1))
(odd1? 0)

(cond
 [(zero? 0) false]
 [else (even1? (sub1 0))])

[true false]
true

4. (+ (local ((define (f x) (g (+ x 1) 22)) (define (g x y) (+ x y)))
(f 10)) 555)

(define (f1 x) (g1 (+ x 1) 22))
(define (g1 x y) (+ x y))
(+ (f1 10) 555)

(+ (g1 (+ 10 1) 22) 555)
(+ (g1 11 22) 555)
(+ (+ 11 22) 555)
(+ 33 555)
588

5. (define (h n) (cond
[(= n 0) empty]
[else (local ((define r (* n n)))
                (cons r (h (- n 1))))]))
(h 2)

(cond
 [(= 2 0) empty]
 [else (local ((define r (* n n)))
         (cons r (h (- n 1))))])

(cond
 [false empty]
 [else (local ((define r (* 2 2)))
         (cons r (h (- 2 1))))])

(define r1 4)
(cons r1 (h 1))

(cons 4 (cond
          [(= 1 0) empty]
          [else (local ((define r (* n n)))
                  (cons r (h (- 1 1))))]))

(cons 4 (cond
          [false empty]
          [else (local ((define r (* n n))))
                (cons r (h 0))]))

(define r2 (* 1 1 ))
(cons 4 (cons r2 (h 0)))

(cons 4 (cons 1 (cond
                 [(= 0 0) empty]
                 [else (local ((define r (* 0 0))))
                       (cons r (h (- 0 0)))])))

(cons 4 (cons 1 empty))
(list 4 1)

