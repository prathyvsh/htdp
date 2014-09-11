#|
(define x 1)
(define y 1)

(local ((define u (set! x (+ x 1)))
        (define v (set! y (- y 1))))
  (* x y))
|#

;; If set was absent local produces (* 1 1) = 1
;; Current definition produces (* 2 0) = 0
