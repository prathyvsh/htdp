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

;; inex* : inex inex -> inex
;; Multiplies two inexact numbers together
(define (inex* num1 num2)
  (local ((define e1 (* (inex-sign num1) (inex-exponent num1)))
          (define e2 (* (inex-sign num2) (inex-exponent num2))))
   (make-legal-inex
    (make-inex (* (inex-mantissa num1)
                  (inex-mantissa num2)) (sign (+ e1 e2)) (abs (+ e1 e2))))))

;; make-legal-inex : inex (improper) -> inex
;; Takes in an illegal inex and makes it into a legal
;; expression
(define (make-legal-inex ix)
  (cond
    [(>= (inex-mantissa ix) 100) (make-legal-inex (reduce-representation ix))]
    [else (create-inex (inex-mantissa ix) (inex-sign ix) (inex-exponent ix))]))
 
;; grow-representation : inex -> inex
;; Gets a higher representation of the inex
(define (grow-representation ix)
  (local ((define exponent (* (inex-sign ix) (inex-exponent ix))))
    (make-inex (* (inex-mantissa ix) 10) (sign (- exponent 1)) (abs (- exponent 1)))))

;; reduce-representation : inex -> inex (improper)
;; Creates an expression with the exponent increased by 1
(define (reduce-representation ix)
  (local ((define exponent (* (inex-sign ix) (inex-exponent ix))))
     (make-inex (round (/ (inex-mantissa ix) 10)) (sign (+ exponent 1)) (abs (+ exponent 1)))))

;; sign : number -> number
;; Returns the sign of the number.
;; 0 is considered positive.
(define (sign n)
  (cond
    [(>= n 0) +1]
    [else -1]))

;; TESTS

(equal? (inex* (make-inex 2 1 4) (make-inex 8 1 10)) (make-inex 16 1 14))
(equal? (inex* (make-inex 20 -1 1) (make-inex 5 1 4)) (make-inex 10 1 4))
(equal? (inex* (make-inex 27 -1 1) (make-inex 7 1 4)) (make-inex 19 1 4))


