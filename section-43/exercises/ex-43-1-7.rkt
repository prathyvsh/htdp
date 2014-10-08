#lang racket
(require lang/htdp-advanced)

;; for-interval :  N (N  ->  N) (N  ->  N) (N  ->  X)  ->  X
;; to evaluate (action i (vector-ref V i)) for i, (step i), ...
;; until (end? i) holds (inclusive)
;; generative recursion: step generates new value, end? detects end
;; termination is not guaranteed 
(define (for-interval i end? step action)
  (cond
   [(end? i) (action i)]
   [else (begin
           (action i)
           (for-interval (step i) end? step action))]))

;; swap : (vectorof X) N N void 
;; Swaps the content at i with j
(define (swap V i j)
  (local ((define temp (vector-ref V i)))
    (begin
      (vector-set! V i (vector-ref V j))
      (vector-set! V j temp))))

;; rotate-left : (vectorof number) -> void
;; Effect: Moves all the items in vector into the adjacent field
;; except for the first item which moves to the last field.
(define (rotate-left V)
  (for-interval (sub1 (vector-length V)) zero? sub1
                (lambda (i)
                  (swap V i (sub1 (vector-length V))))))

;; insert-i-j : (vectorof number) N N -> void
;; Effect: Moves all the items between two indices i and j to the right, except
;; for the right-most one which gets inserted into the i-th field
(define (insert-i-j V i j)
  (for-interval i (lambda (i) (= i j)) add1 (lambda (i) (swap V i j))))


;; vector-reverse! : (vectorof number) -> void
;; Effect: Reverses the vector
(define (vector-reverse! V)
  (local ((define last-index (sub1 (vector-length V))))
    (for-interval 0 (lambda (i) (= i (quotient last-index 2))) add1 (lambda (i) (swap V i (- last-index i))))))

;; find-new-right : (vectorof number) number N N [>= left]  ->  N
;; to determine an index i between left and right (inclusive)
;; such that (< (vector-ref V i) the-pivot) holds
(define (find-new-right V the-pivot left right)
  (cond
    [(= right left) right]
    [else (cond
	    [(< (vector-ref V right) the-pivot) right]
	    [else (find-new-right V the-pivot left (sub1 right))])]))

;; find-new-right-with-for : (vectorof number) number N N -> N
;; Finds the new right according to the partition algorithm of the Quick Sort
(define (find-new-right-with-for V the-pivot left right)
  (local ((define result 0))
  (begin (for-interval right (lambda (i) (= i left)) sub1 (lambda (step-value)
                                                     (cond [(< (vector-ref V step-value) the-pivot)
                                                            (set! result step-value)]
                                                           [else (void)]))) result)))
(define (vector-sum! V)
  (local ((define result 0))
    (begin (for-interval 0 (lambda (i) (= i (sub1 (vector-length V)))) add1
                         (lambda (i)
                           (set! result (+ result (vector-ref V i)))))
           result)))

   
;; TESTS
(define V1 (vector 3 4 5 9))
(define V2 (vector 3 4 5 9))
(define (apply-n-vec n f V)
  (cond
   [(= n 0) (void)]
   [else (begin (f V) (apply-n-vec (sub1 n) f V))]))

(equal? V1 (begin (apply-n-vec (vector-length V2) rotate-left V2) V2))
(equal? V1 (begin (apply-n-vec (vector-length V2) (lambda (V) (insert-i-j V 0 (sub1 (vector-length V)))) V2) V2))

(define V3 (vector 3 4 5 6))
(equal? (begin (insert-i-j V3 1 2) V3) (vector 3 5 4 6))
(define V4 (vector 1 2 3 4))
(equal? (begin (vector-reverse! V4) V4) (vector 4 3 2 1))
(define V5 (vector 1 2 3 4 5))
(equal? (begin (vector-reverse! V5) V5) (vector 5 4 3 2 1))
(define V6 (vector 4 5 6 7 9 3))
(equal? (find-new-right-with-for V6 (vector-ref V6 0) 0 (sub1 (vector-length V6))) 5)
(define V8 (vector 4 5 6 3 7 9))
(equal? (find-new-right-with-for V8 (vector-ref V8 0) 0 (sub1 (vector-length V8))) 3)
(define V9 (vector 21 3 3 5 9 2 1))
(equal? (vector-sum! V9) 44)
(define V10 (vector 1 2 3 4 5 6 7 8 9 10))
(equal? (vector-sum! V10) 55)

;; All of these functions can be defined in terms of vec-for-all since the for loop construct
;; is just another way of going through every element in the array.
