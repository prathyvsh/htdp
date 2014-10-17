#lang racket
(require lang/htdp-advanced)

;; call-status : (vectorof boolean)
;; to keep track of the floors from which calls have been issued 
(define call-status (vector true true true false true true true false))

;; reset :  ->  void
;; effect: to set all fields in call-status to false
(define (reset)
  (vec-for-all (lambda (v i) false) call-status))

;; move! : (vectorof number) (vectorof number)  ->  void
;; effect: to add the fields of v to the corresponding fields of pos 
;; assumption: pos and v have equal length
(define (move! pos v)
  (vec-for-all (lambda (value i) (+ value (vector-ref v i))) pos))

;; vec-for-all : (N X  ->  void) (vectorof X)  ->  void
;; effect: to apply f to all indices and values in vec
(define (vec-for-all f vec)
  (local ((define (apply-function-at idx)
            (cond
             [(zero? idx) (void)]
             [else (begin (vector-set! vec (sub1 idx) (f (vector-ref vec (sub1 idx)) (sub1 idx))) (apply-function-at (sub1 idx)))])))
    (apply-function-at (vector-length vec))))


;; vector*! : number (vectorof numbers) -> void
;; Effect: Multiplies all the numbers in the given
;; vector by the number s
(define (vector*! von s)
  (vec-for-all (lambda (value idx) (* value s)) von))

;; TESTS
(reset)
(equal? call-status (vector false false false false false false false false))

(define p (vector 3 4))
(move! p (vector 0 0))
(equal? p (vector 3 4))
(move! p (vector 5 5))
(equal? p (vector 8 9))

(define p2 (vector 5 8 0 2 3 2 1 3))
(move! p2 (vector 1 1 1 1 1 1 1 2))
(equal? p2 (vector 6 9 1 3 4 3 2 5))

(define v1 (vector 2 3 25 20 23 22))
(vector*! v1 2)
(equal? v1 (vector 4 6 50 40 46 44))
