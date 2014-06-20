(define (in-interval-1? x)
       (and (< -3 x) (< x 0)))
;; (-3, 0)

(define (in-interval-2? x)
       (or (< x 1) (> x 2)))
;; (-inf,1) + (2,inf)

(define (in-interval-3? x)
       (not (and (<= 1 x) (<= x 5))))
;; (-inf, 1) + (5, inf)


(in-interval-1? -2)
;; (and (< -3 -2) (< -2 0))
;; (and true true)
;; true

(in-interval-2? -2)
;; (or (< -2 1) (> -2 2))
;; (or true false)
;; true

(in-interval-3? -2)
;; (not (and (<= 1 -2) (<= -2 5)))
;; (not (and false true))
;; (not false)
;; true
