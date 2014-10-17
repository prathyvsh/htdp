#|
1. (define x 0)
     (define y 1)
     (begin 
       (set! x 3)
       (set! y 4)
       (+ (* x x) (* y y)))

;; NEXT STATE
(define x 3)
(define y 1)
(begin (void) (set! y 4) (+ (* x x) (* y y)))

2. (define x 0)
     (set! x 
       (cond
	 [(zero? x) 1]
	 [else 0]))

;; NEXT STATE

(define x 0)
(set! x 1)

3. (define (f x)
       (cond [(zero? x) 1]
            [else 0]))
     (begin (set! f 11) f)

;; NEXT STATE

(define (f 11))
(begin (set! f 11) f)

|#
