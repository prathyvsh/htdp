#lang racket
(require lang/htdp-advanced)

;; in-place-sort : (vectorof number)  ->  void
;; effect: to modify V such that it contains the same items 
;; as before but in ascending order 
(define (in-place-sort V)

  (local (
          ;; sort-aux : (vectorof number) N  ->  void
          ;; effect: Sorts the left fragment of the vector
          ;; in ascending order from [0,i)
          (define (sort-aux i)
            (cond
             [(zero? i) (void)]
             [else (begin
                     ;; sort the segment [0,(sub1 i)):
                     (sort-aux (sub1 i))
                     ;; insert (vector-ref V (sub1 i)) into the segment 
                     ;; [0,i) so that it becomes sorted''
                     (insert (sub1 i)))]))

          ;; sort2-aux : (vectorof number) N  ->  void
          ;; effect: Sorts the right fragment of the vector
          ;; in ascending order from [i,M) where M is the length
          ;; of the array.
          (define (sort2-aux i)
            (cond
             [(zero? i) (void)]
             [else (begin
                     (insert2 (sub1 i))
                     (sort2-aux (sub1 i)))]))

          ;; insert2 : N  ->  void
          ;; to place the value in the i-th into its proper place 
          ;; in the [i, M) segment of V, where M is the length of the array.
          ;; assume: the segment  [i-1,M) of V is sorted.
          (define (insert2 i)
            (cond
             [(= i (- (vector-length V) 1)) (void)]
             [else (cond
                    [(> (vector-ref V i) (vector-ref V (add1 i)))
                     (begin
                       (swap i (add1 i))
                       (insert2 (add1 i)))]
                    [else (void)])]))

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
          ;; Swaps the content at i with j
          (define (swap i j)
            (local ((define temp (vector-ref V i)))
              (begin
                (vector-set! V i (vector-ref V j))
                (vector-set! V j temp)))))

    (begin (sort2-aux (vector-length V)) V)))

;; TESTS
(define unsorted-vector (vector 9 2 3 4 5 9 2 1 1 9 0 3))
(in-place-sort unsorted-vector)
