#lang racket
(require lang/htdp-advanced)

(define-struct girlfriends (name hair eyes number-past-dates))

;; one-more-date : girlfriends -> void
;; Increments the number-past-dates by 1
(define (one-more-date gf)
  (set-girlfriends-number-past-dates! gf (add1 (girlfriends-number-past-dates gf))))


;; TESTS
(define amy (make-girlfriends 'Amy 'Brown 'Grey 0))
(one-more-date amy)
(equal? amy (make-girlfriends 'Amy 'Brown 'Grey 1))
