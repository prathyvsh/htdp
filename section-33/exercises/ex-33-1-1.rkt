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

;; inex+ : inex inex -> inex
;; Adds two inexact numbers together
(define (inex+ num1 num2)
  (local ((define e1 (* (inex-sign num1) (inex-exponent num1)))
          (define e2 (* (inex-sign num2) (inex-exponent num2))))
    (cond
      [(equal? e1 e2) (make-legal-inex (make-inex (+ (inex-mantissa num1) (inex-mantissa num2)) (inex-sign num1) (inex-exponent num1)))]
      [(equal? (abs (- e1 e2)) 1) (cond
                                    [(equal? (max e1 e2) e1) (inex+ (grow-representation num1) num2)]
                                    [else (inex+ num1 (grow-representation num2))])]
      [else (error 'inex+ "Cannot add given numbers")])))

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

(define (equal-pairs? f pairs)
  (andmap (lambda (x) (equal? (f (first x)) (second x))) pairs))


(equal-pairs? make-legal-inex (list (list (make-inex 100 1 1) (make-inex 10 1 2))
                                         (list (make-inex 1000 1 1) (make-inex 10 1 3))
                                          (list (make-inex 10 1 1) (make-inex 10 1 1))
                                         (list (make-inex 100 -1 1) (make-inex 10 1 0))
                                        (list (make-inex 199 -1 2) (make-inex 20 -1 1))))

(equal-pairs? grow-representation (list (list (make-inex 10 1 2) (make-inex 100 1 1))
                                         (list (make-inex 10 1 3) (make-inex 100 1 2))
                                          (list (make-inex 10 1 1) (make-inex 100 1 0))
                                         (list (make-inex 10 1 0) (make-inex 100 -1 1))
                                        (list (make-inex 19 -1 1) (make-inex 190 -1 2))))


(equal? (inex+ (make-inex 50 1 0) (make-inex 30 1 0)) (make-inex 80 1 0))
(equal? (inex+ (make-inex 10 1 1) (make-inex 10 1 2)) (make-inex 11 1 2))
(equal? (inex+ (make-inex 55 1 0) (make-inex 55 1 0)) (make-inex 11 1 1))
(equal? (inex+ (make-inex 55 1 0) (make-inex 55 1 0)) (make-inex 11 1 1))
(equal? (inex+ (make-inex 1 1 1) (make-inex 1 1 0)) (make-inex 11 1 0))
(equal? (inex+ (make-inex 1 1 1) (make-inex 1 2 0)) (make-inex 11 1 0))
(equal? (inex+ (create-inex 1 1 0) (create-inex 1 -1 1)) (create-inex 11 -1 1))
(equal? (inex+ (make-inex 99 1 1) (make-inex 1 1 1)) (make-inex 10 1 2))
(equal? (inex+ (make-inex 99 1 97) (make-inex 9 1 98)) (make-inex 19 1 98))
(equal? (inex+ (make-inex 99 1 98) (make-inex 9 1 97)) (make-inex 1 1 99))

;;Produces Error
;(inex+ (make-inex 50 1 99) (make-inex 50 1 0))
