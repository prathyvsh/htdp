#lang racket
(require lang/htdp-advanced)

;; eq-posn : posn posn  ->  boolean
;; to determine whether two posn structures 
;; are affected by the same mutation 
(define (eq-posn p1 p2)
  (local (;; save old x values of p1 and p2
	  (define old-x1 (posn-x p1))
	  (define old-x2 (posn-x p2))
	  ;; modify both x fields of p1 and p2
	  (define effect1 (set-posn-x! p1 5))
	  (define effect2 (set-posn-x! p2 6))
	  ;; now compare the two fields
	  (define same (= (posn-x p1) (posn-x p2)))
	  ;; restore old values
	  (define effect3 (set-posn-x! p1 old-x1))
	  (define effect4 (set-posn-x! p2 old-x2)))
    same))

;; TESTS

(define a (make-posn 5 3))
(define b a)
(define c (make-posn 5 3))
(eq-posn a b)
(not (eq-posn a c))
