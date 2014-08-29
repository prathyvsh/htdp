#lang racket
(require lang/htdp-intermediate-lambda)


;; An inex is a structure: 
;; (make-inex m s e) 
;; where m and e are natural numbers in [0,99] and s is +1 or -1.
(define-struct inex (mantissa sign exponent))

;; create-inex : N N N  ->  inex
;; to make an instance of inex after checking the appropriateness
;; of the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s +1) (= s -1)))
     (make-inex m s e)]
    [else
     (error 'make-inex "(<= 0 m 99), +1 or -1, (<= 0 e 99) expected")]))

;; inex->number : inex  ->  number
;; to convert an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex) 
     (expt 10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

;; TESTS
(equal? (inex->number (create-inex 50 -1 20))
        (inex->number (create-inex 5 -1 19)))
