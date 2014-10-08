#lang racket
(require lang/htdp-advanced)

;; in-place-sort : (vectorof number)  ->  void
;; effect: to modify V such that it contains the same items 
;; as before but in ascending order 
(define (in-place-sort V)

  (local (
;; sort-aux : (vectorof number) N  ->  void
;; effect: to sort the interval [0,i) of V in place 
(define (sort-aux i)
  (cond
   [(zero? i) (void)]
   [else (begin
           ;; sort the segment [0,(sub1 i)):
           (sort-aux (sub1 i))
           ;; insert (vector-ref V (sub1 i)) into the segment 
           ;; [0,i) so that it becomes sorted''
           (insert (sub1 i)))]))

;; insert : N (vectorof number)  ->  void
;; to place the value in the i-th into its proper place 
;; in the [0,i] segment of V
;; assume: the segment  [0,i) of V is sorted
(define (insert i) 
  (cond
   [(zero? i) (void)]
   [else (cond
          [(> (vector-ref V (sub1 i)) (vector-ref V i)) 
           (begin
             (swap (- i 1) i)
             (insert (sub1 i)))]
          [else (void)])]))

;; swap : (vectorof X) N N void 
(define (swap i j)
  (local ((define temp (vector-ref V i)))
    (begin
      (vector-set! V i (vector-ref V j))
      (vector-set! V j temp)))))

  (begin (sort-aux (vector-length V)) V)))

;; TESTS
;(define test-vector (vector 0 4 5 3 9))
;(swap test-vector 0 1)
;(equal? test-vector (vector 4 0 5 3 9))
;(swap test-vector 4 2)
;(equal? test-vector (vector 4 0 9 3 5))
;(define another-vector (vector 1 2 8 0 3 2))
;(insert 3 another-vector)
;(equal? another-vector (vector 0 1 2 8 3 2))
;(sort-aux another-vector 3)
;(equal? another-vector (vector 0 1 2 8 3 2))
;(sort-aux another-vector 6)
;(equal? another-vector (vector 0 1 2 2 3 8))
(define unsorted-vector (vector 3 8 2 3 0 9 2))
(equal? (in-place-sort unsorted-vector) (vector 0 2 2 3 3 8 9))
