#lang racket

;;(filter1 < (cons 6 (cons 4 empty)) 5) = (filter1 < (cons 4 empty) 5)


(cond
 [(empty? (cons 6 (cons 4 empty))) empty]
 [else (cond
        [(< (first (cons 6 (cons 4 empty))) 5) 
         (cons (first (cons 6 (cons 4 empty)))
               (filter1 < (rest (cons 6 (cons 4 empty))) 5))]
        [else
         (filter1 < (rest (cons 6 (cons 4 empty))) 5)])])

(cond
 [false empty]
 [else (cond
        [(< (first (cons 6 (cons 4 empty))) 5) 
         (cons (first (cons 6 (cons 4 empty)))
               (filter1 < (rest (cons 6 (cons 4 empty))) 5))]
        [else
         (filter1 < (rest (cons 6 (cons 4 empty))) 5)])])

(cond
 [(< (first (cons 6 (cons 4 empty))) 5) 
  (cons (first (cons 6 (cons 4 empty)))
        (filter1 < (rest (cons 6 (cons 4 empty))) 5))]
 [else
  (filter1 < (rest (cons 6 (cons 4 empty))) 5)])

(cond
 [(< 6 5) 
  (cons (first (cons 6 (cons 4 empty)))
        (filter1 < (rest (cons 6 (cons 4 empty))) 5))]
 [else
  (filter1 < (rest (cons 6 (cons 4 empty))) 5)])

(cond
 [false (cons (first (cons 6 (cons 4 empty)))
              (filter1 < (rest (cons 6 (cons 4 empty))) 5))]
 [else
  (filter1 < (rest (cons 6 (cons 4 empty))) 5)])

(filter1 < (rest (cons 6 (cons 4 empty))) 5)

(filter1 < (cons 4 empty) 5)

;; :QED
