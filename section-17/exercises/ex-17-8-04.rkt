#lang htdp/bsl

;; contains-same-numbers : list-of-number list-of-numbers -> boolean
(define (contains-same-numbers alist anotherlist)
  (and (all-exists alist anotherlist)
       (all-exists anotherlist alist)))

;; all-exists : list-of-numbers list-of-numbers
;; Determines if all the number in alist is in anotherlist
(define (all-exists alist anotherlist)
  (cond
   [(empty? alist) true]
   [else (and (find (first alist) anotherlist)
	      (all-exists (rest alist) anotherlist))]))

;; find : number list-of-numbers -> boolean
;; Takes in a number and determines if it occurs in the given list
(define (find number lon)
  (cond
   [(empty? lon) false]
   [(= number (first lon)) true]
   [else (find number (rest lon))]))

;; TESTS

;; find
(boolean=? (find 3 (list 2 5 52 3)) true)
(boolean=? (find 2 (list 3 4 5 6)) false)

;; all-exists
(boolean=? (all-exists (list 2 3) (list 3 4 8 2)) true)
(boolean=? (all-exists (list 4 5) (list 4 2 8 3 2 4)) false)

;; contains-same-numbers
(boolean=? (contains-same-numbers (list 1 2 3) (list 3 2 1)) true)
(boolean=? (contains-same-numbers (list 2 1) (list 1 2)) true)
