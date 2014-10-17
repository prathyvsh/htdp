#lang racket
(require lang/htdp-intermediate-lambda)


;; A distribution is
;; (make-distribution number number)
(define-struct distribution (priests cannibals))

;; A boat is
;; (make-boat symbol distribution)
(define-struct boat (at-dock load))

;; A board is
;; (make-board distribution boat distribution
(define-struct board (beg boat end))

;; Possible BOAT-LOADS
;;(make-distribution 0 0)
;;(make-distribution 0 1)
;;(make-distribution 0 2)
;;(make-distribution 1 0)
;;(make-distribution 1 1)
;;(make-distribution 2 0)

#|
;; First Approach
;; make-BOAT-LOAD : number -> (listof distribution)
;; Creates a list of all possible boat loads.
(define (make-BOAT-LOAD capacity)
  (local (;; Create a list by choosing the lowest of MC and BOAT-CAPACITY
          (define l (build-list (+ 1 (min capacity MC)) (lambda (x) x)))
          (define predicate (lambda (x y) (<= (+ x y) capacity)))
          (define (make-distributions n lst)
            (foldr (lambda (x y) (if (predicate n x) (cons (make-distribution n x) y) y)) empty lst))
          (define (combine-list list1 list2)
            (foldr append empty (map (lambda (x) (make-distributions x list2)) list1))))
    (combine-list l l)))
|#

;; make-BOAT-LOAD : number -> (listof distribution)
;; Creates a list of all possible boat loads.
(define (make-BOAT-LOAD capacity)
  ;; Better Approach
  ;; make-limit-triangle : number -> (listof distribution)
  (local ((define (make-limit-triangle limit)
    (local ((define (make-distributions m c)
              (cond
               [(> m limit) empty]
               [(> (+ m c) limit) (make-distributions (add1 m) 0)]
               [else (cons (make-distribution m c) (make-distributions m (add1 c)))])))
      (make-distributions 0 1))))
  (make-limit-triangle (min capacity MC))))

(define MC 3)
(define BOAT-CAPACITY 2)
(make-BOAT-LOAD BOAT-CAPACITY)



