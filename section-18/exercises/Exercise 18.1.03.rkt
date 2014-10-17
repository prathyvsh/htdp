1. (define A-CONSTANT (not (local
    ((define (odd an) (cond
                        [(= an 0) false]
                        [else (even (- an 1))]))
     (define (even an)                                                                     (cond                                                                             [(= an 0) true]                                                              [else (odd (- an 1))])))
                         (even a-nat-num))))
;; Is not valid since a-nat-num is not defined.

2. (+ (local ((define (f x) (+ (* x x) (* 3 x) 15))
              (define x 100)
              (define f@100 (f x))) f@100)
      1000)
;; Is valid

3. (local ((define CONST 100)
           (define f x (+ x CONST)))
     (define (g x y z) (f (+ x (* y z)))))
;; Is invalid since (define f x (+ x CONST)) is not a valid definition.
