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
   [else (local ((define insert-val (vector-ref V i))
                 (define (shift-and-insert i)
                   (cond
                    [(< i 0) (vector-set! V (add1 i) insert-val)]
                    [else
                     (local ((define current-value (vector-ref V i)))
                       (cond
                        [(> current-value insert-val) (begin (vector-set! V (add1 i) current-value) (shift-and-insert (sub1 i)))]
                        [else (vector-set! V (add1 i) insert-val)]))])))
           (shift-and-insert (sub1 i)))])))

  (begin (sort-aux (vector-length V)) V)))

;; TESTS
(in-place-sort (vector 1 2 3 4 5))

(define vec (vector 2 2 3 8 0 1 2 4 5 3 9 9))
(in-place-sort vec)

(define unsorted-vector (vector 3 8 2 3 0 9 2))
(in-place-sort unsorted-vector)

