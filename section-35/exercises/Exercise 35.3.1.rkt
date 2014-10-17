#|
;; This function is syntactically legal.
(define (f x y)
  (begin (set! x y) y))
|#
