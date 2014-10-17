#lang racket
(require lang/htdp-advanced)

;; list-3-averages : (listof number) -> (listof number)
;; Calculates the 3 sliding averages of given list of numbers
(define (list-3-averages lst)
  (local (
          (define (take-3 l) (take-n 3 l))
          (define (list-3-averages-aux lst)
            (local ((define current-list (take-3 lst)))
              (cond
               [(or (empty? lst) (false? current-list)) empty]
               [else (cons (average current-list) (list-3-averages-aux (rest lst)))]))))
    (list-3-averages-aux lst)))

;; take-n : N (listof number) -> (listof number) or false
;; Takes the first n of the given list
(define (take-n n l)
  (local ((define (cons-or-false m n)
            (cond
             [(false? n) false]
             [else (cons m n)])))
    (cond
     [(= n 0) empty]
     [(empty? l) false]
     [else (cons-or-false (first l) (take-n (sub1 n) (rest l)))])))

;; average : (listof number) -> number
;; Calculates the average of the given list of numbers
(define (average l)
  (local ((define (sum list) (foldr + 0 list))) (/ (sum l) (length l))))

(define (average-vec v) (/ (vector-sum v) (vector-length v)))

;; vector-sum : (vectorof number)  ->  number
;; to compute the sum of the numbers in v
(define (vector-sum v) 
  (local (
;; vector-sum-aux : (vectorof number) N  ->  number
;; to sum the numbers in v with index in [0, i)
(define (vector-sum-aux v i) 
  (cond
    [(zero? i) 0]
    [else (+ (vector-ref v (sub1 i)) 
	     (vector-sum-aux v (sub1 i)))])))
  (vector-sum-aux v (vector-length v))))


#|
(define (vec-3-averages vec)
  (local ((define (take-3 v i) (sub-vector i (+ i 2) v))
          (define (vec-3-averages-aux vec i)
            (local ((define current-vec (take-3 vec i)))
              (cond
               [(or (= i (vector-length vec)) (false? current-vec)) (vector)]
               [else (vector-append (vector (average-vec current-vec))
                                            (vec-3-averages-aux vec (add1 i)))]))))
          (vec-3-averages-aux vec 0)))
|#

;; vec-3-averages : (vectorof number) -> (vectorof number)
;; Calculates the sliding average of 3 of the given vector
(define (vec-3-averages vec)
  (local ((define (take-3 v i) (sub-vector i (+ i 2) v)))
  (build-vector (- (vector-length vec) 2)
                (lambda (i) (average-vec (take-3 vec i))))))

;; sub-vector : N N (vectorof number) -> (vectorof number)
;; Selects a sub portion of the vector
(define (sub-vector from to vec)
  (local ((define (vec-or-false m n)
           (cond
            [(false? n) false]
            [else (vector-append m n)])))
  (cond
   [(> to (sub1 (vector-length vec))) false]
   [(= from to) (vector (vector-ref vec from))]
   [else (vec-or-false (vector (vector-ref vec from)) (sub-vector (add1 from) to vec))])))

(define (vec-3-averages! vec)
  (local ((define (take-3 v i) (sub-vector i (+ i 2) v))
          (define (vec-3-averages-aux vec i)
            (local ((define current-vec (take-3 vec i)))
              (cond
               [(or (= i (vector-length vec)) (false? current-vec)) (sub-vector 0 (- i 1) vec)]
               [else (begin (vector-set! vec i (average-vec current-vec))
                                            (vec-3-averages-aux vec (add1 i)))]))))
          (vec-3-averages-aux vec 0)))
;; TESTS
(list-3-averages (list 1.1 1.12 1.08 1.09 1.11))
(list-3-averages (list 1 1 1))
(list-3-averages (list 1 1 1 1))
(sub-vector 1 4 (vector 3 2 1 4 5 9))
(vec-3-averages (vector 1.1 1.12 1.08 1.09 1.11))
(vec-3-averages! (vector 1.1 1.12 1.08 1.09 1.11))
(vec-3-averages (vector 1 1 1 1))
(vec-3-averages! (vector 1 1 1 1))
