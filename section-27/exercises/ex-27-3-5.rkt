#lang racket
(require lang/htdp-intermediate-lambda)

;; find-root-linear : (number -> number) number -> number
;; Finds the root of a table in a linear fashion.
(define (find-root-linear table length)
  (find-root table (- length 1)))

(define (find-root table length)
  (local ((define current-element (table length))
          (define current-distance (abs (table length))))
    (cond
     [(= length 0) current-element]
     [(<= current-distance (abs (find-root table (sub1 length)))) current-element]
     [else (find-root table (sub1 length))])))


;; find-root-discrete : (number -> number) number -> number
;; Finds the root of a table using binary search
;; ASSUMPTION: table is monotonous.
(define (find-root-discrete table length)
  (determine-least-in-bounds 0 (- length 1) table))

;; determine-least-in-bounds : number number (number -> number) -> number
;; Determines the least number in the bounds between left and right

;; ASSUMPTION: i) right > left ii) table is monotonous

;; TERMINATION ARGUMENT: This function terminates since the search
;; space is getting halved in each recursive call. And it is done
;; in such a way that the number is floored in case of a decimal,
;; hence when two distinct numbers are passed in the least possible
;; difference between them will be 1.
(define (determine-least-in-bounds left right table)
  (local ((define mid (floor (/ (+ left right) 2)))
          (define m (table mid))
          (define r (table right))
          (define l (table left))
          (define distance-of-l (abs l))
          (define distance-of-r (abs r))
          (define distance-of-m (abs mid)))
    (cond [(<= (- right left) 1) (min (abs (table left)) (abs (table right)))]
          [else (cond [(or (<= m 0 r) (>= m 0 r))
                       (min distance-of-m distance-of-r (determine-least-in-bounds mid right table))]
                      [(or (<= l 0 m) (>= l 0 m))
                       (min distance-of-m distance-of-l (determine-least-in-bounds left mid table))])])))

;; TESTS

;; g : N -> number
(define (g i)
  (cond
   [(= i 0) -9]
   [(= i 1) 23]
   [(= i 2) 40]
   [(= i 3) 10]))

;; h : N -> number
(define (h i)
  (cond
   [(= i 0) -9]
   [(= i 1) -6]
   [(= i 2) 1]
   [(= i 3) 2]
   [(= i 4) 8]))

(define (q i)
  (cond
   [(= i 0) 9]
   [(= i 1) 6]
   [(= i 2) 1]
   [(= i 3) -2]))


(equal? (find-root-linear g 4) -9)
(equal? (find-root-discrete h 4) 1)
(equal? (find-root-discrete q 4) 1)

;; In the linear search, the search takes 1024 searches where as in
;; discrete search it would take only 10 searches as the resultant searches
;; space is getting halved each time.
