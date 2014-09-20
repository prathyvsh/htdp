(define (ff-make-posn x y)
  (lambda (select)
    (select x y)))

(define (ff-posn-x a-ff-posn)
  (a-ff-posn (lambda (x y) x)))

(define (ff-posn-y a-ff-posn)
  (a-ff-posn (lambda (x y) y)))

(ff-posn-x (ff-make-posn V-1 V2))

;; The calculation demonstrates
;; that the alternative definition
;; works adequately as the previous
;; definition
