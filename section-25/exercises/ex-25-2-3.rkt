#lang racket
(require lang/htdp-intermediate-lambda)

;; insertion-sort : list-of-numbers -> list-of-numbers
;; to create a sorted list of numbers from all the numbers in alon
(define (insertion-sort alon)
  (local (
(define (i-sort alon)
  (cond
   [(empty? alon) empty]
   [else (insert (first alon) (i-sort (rest alon)))])))
  (reverse (i-sort alon))))


;; insert : number list-of-numbers -> list-of-numbers
;; to create a list of numbers from n and the numbers on alon
;; that is sorted in descending order; alon is already sorted
(define (insert n alon)
  (cond
   [(empty? alon) (cons n empty)]
   [else (cond
          [(>= n (first alon)) (cons n alon)]
          [(< n (first alon)) (cons (first alon)
                                    (insert n (rest alon)))])]))
;; TESTS
(equal? (insertion-sort (list 2 2 5 8 2 1 3 3 4)) (list 1 2 2 2 3 3 4 5 8))


;; quick-sort : (listof number)  ->  (listof number)
;; to create a list of numbers with the same numbers as
;; alon sorted in ascending order
;; assume that the numbers are all distinct 
(define (combined-quick-sort threshold alon)
  (cond
   [(< (length alon) threshold) (insertion-sort alon)]
   [(empty? alon) empty]
   [else (append
          (combined-quick-sort threshold
                               (smaller-items alon (first alon))) 
          (list (first alon)) 
          (combined-quick-sort threshold
                               (larger-items alon (first alon))))]))

;; larger-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are larger than threshold
(define (larger-items alon threshold)
  (cond
   [(empty? alon) empty]
   [else (if (> (first alon) threshold) 
             (cons (first alon) (larger-items (rest alon) threshold))
             (larger-items (rest alon) threshold))]))

;; smaller-items : (listof number) number  ->  (listof number)
;; to create a list with all those numbers on alon  
;; that are smaller than threshold
(define (smaller-items alon threshold)
  (cond
   [(empty? alon) empty]
   [else (if (< (first alon) threshold) 
             (cons (first alon) (smaller-items (rest alon) threshold))
             (smaller-items (rest alon) threshold))]))

;; TESTS
(equal? (combined-quick-sort 3 (list 3 2 32 24 332)) (list 2 3 24 32 332))
(equal? (combined-quick-sort 8 (list 8 9 12 3 2 32 24 332)) (list 2 3 8 9 12 24 32 332))
