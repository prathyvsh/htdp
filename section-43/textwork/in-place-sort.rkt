#lang racket
(require lang/htdp-advanced)

;; in-place-sort : (vectorof number)  ->  void
;; effect: to modify V such that it contains the same items 
;; as before but in ascending order 
(define (in-place-sort V) (sort-aux V (vector-length V)))

;; sort-aux : (vectorof number) N  ->  void
;; effect: to sort the interval [0,i) of V in place 
(define (sort-aux V i)
  (cond
   [(zero? i) (void)]
   [else (begin
           ;; sort the segment [0,(sub1 i)):
           (sort-aux V (sub1 i))
           ;; insert (vector-ref V (sub1 i)) into the segment 
           ;; [0,i) so that it becomes sorted''
           (insert (sub1 i) V))]))

;; insert : N (vectorof number)  ->  void
;; to place the value in the i-th into its proper place 
;; in the [0,i] segement of V
;; assume: the segment  [0,i) of V is sorted
(define (insert i V) 
  (cond
   [(zero? i) (void)]
   [else (cond
          [(> (vector-ref V (sub1 i)) (vector-ref V i)) 
           (begin
             (swap V (- i 1) i)
             (insert (sub1 i) V))]
          [else (void)])]))

;; swap : (vectorof X) N N void 
(define (swap V i j)
  (local ((define temp (vector-ref V i)))
    (begin
      (vector-set! V i (vector-ref V j))
      (vector-set! V j temp))))

;; TESTS
(define test-vector (vector 0 4 5 3 9))
(swap test-vector 0 1)
(equal? test-vector (vector 4 0 5 3 9))
(swap test-vector 4 2)
(equal? test-vector (vector 4 0 9 3 5))
