#lang racket
(require lang/htdp-intermediate-lambda)

#|
;; HAND EVALUATION

Step 0
(quick-sort (list 11 8 14 7))

Step 1
(append (quick-sort (list 8 7))
        (list 11)
        (quick-sort (list 14)))

Step 2
(append (append (quick-sort (list 7))
                (list 8)
                (quick-sort empty))
        (list 11)
        (quick-sort (list 14)))

Step 3
(append (append (append (quick-sort empty)
                        (list 7)
                        (quick-sort empty))
                (list 8)
                (quick-sort empty))
        (list 11)
        (quick-sort (list 14)))

Step 4
(append (append (append empty (list 7) empty)
                (list 8)
                (quick-sort empty))
        (list 11)
        (quick-sort (list 14)))

Step 5
(append (append (list 7)
                (list 8)
                (quick-sort empty))
        (list 11)
        (quick-sort (list 14)))

Step 6
(append (append (list 7) (list 8) empty)
        (list 11)
        (quick-sort (list 14)))

Step 7
(append (list 7 8)
        (list 11)
        (quick-sort (list 14)))

Step 8
(append (list 7 8)
        (list 11)
        (append (quick-sort empty)
        (list 14)
        (quick-sort empty)))

Step 9
(append (list 7 8)
        (list 11)
        (append empty (list 14) empty))

Step 10
(append (list 7 8) (list 11) (list 14))


Step 11
(list 7 8 11 14)

|#

;; MODIFIED QUICK SORT

;; quick-sort : (listof number)  ->  (listof number)
;; to create a list of numbers with the same numbers as
;; alon sorted in ascending order
;; assume that the numbers are all distinct 
(define (quick-sort alon)
  (cond
    [(empty? alon) empty]
    [(empty? (rest alon)) (list (first alon))]
    [else (append (quick-sort (smaller-items alon (first alon))) 
	    	  (list (first alon)) 
		  (quick-sort (larger-items alon (first alon))))]))

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
(quick-sort (list 8 2 3 11))

#|
;; HAND EVALUATION OF MODIFIED QUICK SORT

Step 0
(quick-sort (list 11 8 14 7))

Step 1
(append (quick-sort (list 8 7))
        (list 11)
        (quick-sort (list 14)))

Step 2
(append (append (quick-sort (list 7))
                (list 8)
                (quick-sort empty))
        (list 11)
        (quick-sort (list 14)))

Step 3
(append (append (list 7)
                (list 8)
                (quick-sort empty))
        (list 11)
        (quick-sort (list 14)))

Step 4
(append (append (list 7) (list 8) empty)
        (list 11)
        (quick-sort (list 14)))

Step 5
(append (list 7 8)
        (list 11)
        (quick-sort (list 14)))

Step 6
(append (list 7 8) (list 11) (list 14))


Step 7
(list 7 8 11 14)

;; It saved 4 steps
|#
