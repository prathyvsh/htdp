#lang racket

;; qsort : (vectorof number)  ->  (vectorof number)
;; effect: to modify V such that it contains the same items as before,
;; in ascending order  
(define (qsort V)
  (local (

;; qsort-aux : (vectorof number) N N  ->  (vectorof number)
;; effect: sort the interval [left,right] of vector V
;; generative recursion
(define (qsort-aux left right)
  (cond
   [(>= left right) V]
   [else (local ((define new-pivot-position (partition left right)))
           (begin (qsort-aux left (sub1 new-pivot-position))
                  (qsort-aux (add1 new-pivot-position) right)))]))

;; partition : (vectorof number) N N  ->  N
;; to determine the proper position p of the pivot-item 
;; effect: rearrange the vector V so that 
;; -- all items in V in [left,p) are smaller than the pivot item
;; -- all items of V in (p,right] are larger than the pivot item
;; generative recursion
;; Termination argument: new-left and new-right always come closer when the get executed.
;; Since a number is neither > or < itself which are the incremental/decremental conditions
;; for new-left and new right respectively. This means that they will eventually cross over
;; and hence partition terminates.
(define (partition left right)
  (local ((define pivot-position left)
          (define the-pivot (vector-ref V left))
          (define (partition-aux left right)
            (local ((define new-right (find-new-right the-pivot left right))
                    (define new-left (find-new-left the-pivot left right)))
              (cond
               [(>= new-left new-right)
                (begin
                  (swap pivot-position new-right)
                  new-right)]
               [else ; (< new-left new-right)
                (begin
                  (swap new-left new-right)
                  (partition-aux new-left new-right))]))))
    (partition-aux left right)))

;; find-new-right : (vectorof number) number N N [>= left]  ->  N
;; to determine an index i between left and right (inclusive)
;; such that (< (vector-ref V i) the-pivot) holds
(define (find-new-right the-pivot left right)
  (find-bounds V the-pivot left right < (lambda (l r) r) (lambda (x) x) sub1))

;; find-new-left : (vectorof number) number N N [>= left]  ->  N
;; to determine an index i between left and right (inclusive)
;; such that (> (vector-ref V i) the-pivot) holds
(define (find-new-left the-pivot left right)
  (find-bounds V the-pivot left right > (lambda (l r) l) add1 (lambda (x) x)))

(define (find-bounds pivot left right op chosen mod-left mod-right)
  (local (
(define (find left right)
  (local ((define result (chosen left right)))
  (cond
    [(= right left) result]
    [else (cond
            [(op (vector-ref V result) pivot) result]
            [else (find (mod-left left) (mod-right right))])]))))
    (find left right)))

;; swap : (vectorof X) N N void 
(define (swap i j)
  (local ((define temp (vector-ref V i)))
    (begin
      (vector-set! V i (vector-ref V j))
      (vector-set! V j temp))))

)
  (qsort-aux V 0 (sub1 (vector-length V))))


(equal? (qsort (vector 2 3 2 1 4 9 0 45)) (vector 0 1 2 2 3 4 9 45))
(equal? (qsort (vector 2 1)) (vector 1 2))
(equal? (qsort (vector 1 2 2 3 3 4 9 2 12 29 1)) (vector 1 1 2 2 2 3 3 4 9 12 29))
(equal? (qsort (vector 1 2 3 4 5)) (vector 1 2 3 4 5))
(equal? (qsort (vector 5 4 3 2 1)) (vector 1 2 3 4 5))
