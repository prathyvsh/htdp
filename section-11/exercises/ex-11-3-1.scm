;; random-n-m : integer integer -> integer
;; Assume n < m
(define (random-n-m n m)
  (+ (random (- m n))))

;; (random n) produces a number in the interval [0,n)
;; Hence random (random (- m n)) produces a number in [0, m - n)
;; Adding n to this equation gives:
;; [0+n , m - n + n) = [n, m) which is a number between n and m

;; PURPOSE
;; Creates a number between n and m

;; EXAMPLE
(random-n-m 3 5) "should be"
(+ (random (- 5 3)) 3) "should be"
(+ (random 2) 3) "should be"
(+ 1 3) "should be"
4
;; which is a number in the interval [3,5)

