;; 4*n + 2 = 62
(define (eqn1 n)
  (= (+ (* 4 n) 2) 62))

;; 2*n^2 = 102
(define (eqn2 n)
  (= (* 2(sqr n)) 102)) 

;; 4*n^2 + 6*n + 2 = 462
(define (eqn3 n)
  (= (+ (+ (* 4 (sqr n)) (* 6 n)) 2) 462))


;; COMPUTATIONS

(eqn1 10)
(eqn1 12)
(eqn1 14)

(eqn2 10)
(eqn2 12)
(eqn2 14)

(eqn3 10)
(eqn3 12)
(eqn3 14)
