;; list-sum : (listof number)  ->  number 
;; to compute the sum of the numbers on alon
(define (list-sum alon)
  (list-sum-aux alon (length alon)))

;; list-sum-aux : N (listof number)  ->  number 
;; to compute the sum of the first L numbers on alon
(define (list-sum-aux L alon)
  (cond
    [(zero? L) 0]
    [else (+ (list-ref alon (sub1 L)) (list-sum-aux (sub1 L) alon))]))

(define (sum a-list-of-nums)
  (cond
    [(empty? a-list-of-nums) 0]
    [else (+ (first a-list-of-nums) (sum (rest a-list-of-nums)))]))

;; vector-sum : (vectorof number)  ->  number
;; to compute the sum of the numbers in v
(define (vector-sum v) 
  (vector-sum-aux v (vector-length v)))
;; vector-sum-aux : (vectorof number) N  ->  number
;; to sum the numbers in v with index in [0, i)
(define (vector-sum-aux v i) 
  (cond
    [(zero? i) 0]
    [else (+ (vector-ref v (sub1 i)) 
	     (vector-sum-aux v (sub1 i)))]))

#|
;; RUNNING TIMES

list-sum-aux takes order of N for each execution. Hence for a list of
N items, it takes O(N^2).

vector-sum-aux takes a constant time for each execution since vector-ref is
constant and hence it takes O(N) for a vector of N items.

sum since it uses first also takes a constant time for each execution of it
and hence performs in O(N) time.

This suggests that list-ref should be used with caution and only when necessary.

|#


