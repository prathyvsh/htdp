(number? (make-posn 2 3))
;; false

(number? (+ 12 10))
;; true

(posn? 23)
;; false

(posn? (make-posn 23 3))
;; true

(star? (make-posn 23 3))
;; false
