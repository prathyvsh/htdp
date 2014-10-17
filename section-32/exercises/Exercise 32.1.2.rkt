#lang racket
(require lang/htdp-intermediate-lambda)

;; An exp is either
;; symbol
;; (Lam symbol exp)
;; or (make-apply exp exp)

;; A Lam is
;; (make-Lam (symbol exp))
(define-struct Lam (var exp))

;; A Apply is
;; (amke-Apply (exp exp)
(define-struct Apply (exp1 exp2))

;; free-or-bound : Lam  ->  Lam 
;; To replace each non-binding occurrence of a variable in a-lam 
;; with 'free or 'bound, depending on whether the 
;; occurrence is bound or not.
(define (free-or-bound a-lam)
  (local (;; binder-acc Lam (listof symbol)
          ;; Accumulator collects all the Lam-var s encounted so far.
          (define (binder-acc a-lam acc)
            (local ((define exp (Lam-exp a-lam))
                    (define var (Lam-var a-lam)))
              (make-Lam var (process-exp exp (cons var acc)))))
          ;; process-exp : exp (listof symbol)
          ;; Process a given expression to replace the free and bound variables
          (define (process-exp exp acc)
            (cond
             [(symbol? exp) (cond [(contains? exp acc) 'bound]
                                  [else 'free])]
             [(Lam? exp) (binder-acc exp acc)]
             [(Apply? exp) (free-or-bound-apply exp acc)]
             [else exp]))
          ;; free-or-bound-apply : Apply
          (define (free-or-bound-apply exp acc)
            (local ((define exp1 (Apply-exp1 exp))
                    (define exp2 (Apply-exp2 exp)))
              (make-Apply (process-exp exp1 acc) (process-exp exp2 acc)))))
    (binder-acc a-lam empty)))

;; contains? : X (listof X)
;; Determines if item is present in given list
(define (contains? item a-list)
  (ormap (lambda (x) (equal? item x)) a-list))

;; TESTS
(define lamb-free-y (make-Lam 'x (make-Lam 'z 'y)))
(define lamb-bound-y (make-Lam 'x (make-Lam 'y 'y)))
(define lamb-bounded-y (make-Lam 'y (make-Lam 'x 'y)))
(define lamb-apply-lam (make-Lam 'a (make-Apply (make-Lam 'b 'b) (make-Lam 'c 'c))))
(define lamb-apply-lam2 (make-Lam 'a (make-Apply (make-Lam 'b 'a) (make-Lam 'c 'c))))
(define lamb-apply-lam3 (make-Lam 'a (make-Apply (make-Lam 'b 'x) (make-Lam 'c 'c))))
(define lamb-apply-lam4 (make-Lam 'y (make-Lam 'x (make-Apply (make-Lam 'q 'x) (make-Lam 'x 'y)))))
(define lambda-nest (make-Lam 'x (make-Apply (make-Lam 'b 'x) (make-Lam 'c 'b))))


(equal? (free-or-bound (make-Lam 'x 'y))
        (make-Lam 'x 'free))
(equal? (free-or-bound lamb-free-y)
        (make-Lam 'x (make-Lam 'z 'free)))
(equal? (free-or-bound lamb-bound-y)
        (make-Lam 'x (make-Lam 'y 'bound)))
(equal? (free-or-bound lamb-bounded-y)
        (make-Lam 'y (make-Lam 'x 'bound)))
(equal? (free-or-bound lamb-apply-lam)
        (make-Lam 'a (make-Apply (make-Lam 'b 'bound) (make-Lam 'c 'bound))))
(equal? (free-or-bound lamb-apply-lam2)
        (make-Lam 'a (make-Apply (make-Lam 'b 'bound) (make-Lam 'c 'bound))))
(equal? (free-or-bound lamb-apply-lam3)
        (make-Lam 'a (make-Apply (make-Lam 'b 'free) (make-Lam 'c 'bound))))
(equal? (free-or-bound lamb-apply-lam4)
        (make-Lam 'y (make-Lam 'x (make-Apply (make-Lam 'q 'bound) (make-Lam 'x 'bound)))))
(equal? (free-or-bound lambda-nest)
        (make-Lam 'x (make-Apply (make-Lam 'b 'bound) (make-Lam 'c 'free))))

(equal? (free-or-bound (make-Lam 'y 'x)) (make-Lam 'y 'free))
(equal? (free-or-bound (make-Lam 'x (make-Lam 'z 'y))) (make-Lam 'x (make-Lam 'z 'free)))

(equal? (free-or-bound (make-Lam 'x 'x)) (make-Lam 'x 'bound))

(equal? (free-or-bound (make-Lam 'q (make-Apply (make-Apply 'x (make-Apply (make-Lam 'y 'q) 'x)) 'q)))
        (make-Lam 'q (make-Apply (make-Apply 'free (make-Apply (make-Lam 'y 'bound) 'free)) 'bound)))
