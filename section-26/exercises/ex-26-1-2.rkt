#lang racket
(require lang/htdp-intermediate-lambda)

;; merge-sort : (listof number) -> (listof number)
(define (merge-sort n)
  (repeat-till-sorted (make-singles n)))

(define (repeat-till-sorted a-list)
  (cond
   [(empty? (rest a-list)) (first a-list)]
   [else (repeat-till-sorted (merge-all-neighbors a-list))]))

;; make-singles : (listof number) -> (listof (listof number))
(define (make-singles alon) (map list alon))

;; merge-all-neighbors : (listof (listof number)) -> (listof number)
;; Merge neighbours function combines the adjacent 
(define (merge-all-neighbors a-list)
  (cond
   [(empty? a-list) empty]
   [(empty? (rest a-list)) (cons (first a-list) empty)]
   [else
    (local ((define first-set (first a-list))
            (define next-set (first (rest a-list))))
      (cons (dove-tail first-set next-set) (merge-all-neighbors (rest (rest a-list)))))]))

;; The list is not always half as long since for odd inputs the last element is not paired.
;; So for a list with 3 elements, there would be 2 elements in the result.

;; dove-tail : (listof number) (listof number) -> (listof number)
;; merges the elements in a sorted order.
;; ASSUMPTION : a and b are in the sorted order
(define (dove-tail a b)
  (cond [(empty? a) b]
   [(empty? b) a]
   [(< (first a) (first b)) (cons (first a) (dove-tail (rest a) b))]
   [else (cons (first b) (dove-tail a (rest b)))]))

;; simplified-merge-sort : (listof number) -> (listof number)
(define (m-sort l)
  (local ((define singles (make-singles l))
          (define (sort n)
            (cond [(empty? n) empty]
                  [(empty? (rest n)) (first n)]
                  [else (dove-tail (dove-tail (first n) (second n)) (sort (rest (rest n))))])))
    (sort singles)))

;; TESTS
(equal? (merge-sort (list 3 3 2 4 5)) (list 2 3 3 4 5))
(equal? (merge-sort (list 2 3)) (list 2 3))
(equal? (merge-sort (list 5 2 3 1 3 4)) (list 1 2 3 3 4 5))

(equal? (merge-all-neighbors empty) empty)
(equal? (merge-all-neighbors (list (list 5))) (list (list 5)))
(equal? (merge-all-neighbors (list (list 2) (list 3) (list 5) (list 9) (list 10))) (list (list 2 3)
                                                                                         (list 5 9)
                                                                                         (list 10)))
(equal? (merge-all-neighbors (list (list 2 3) (list 5 9))) (list (list 2 3 5 9)))
(equal? (merge-all-neighbors (list (list 2 3 5 9))) (list (list 2 3 5 9)))
(define test-list (list 4 2 3 2 3 4))
(equal? (merge-sort test-list) (m-sort test-list))
