#lang racket
(require lang/htdp-intermediate-lambda)


;; swap : (listof number) (listof (listof number))
;; Swaps given row with the next row in the list of numbers
(define (swap swapper swappee)
  (cond
   [(empty? swappee) empty]
   [else (cons swapper (remove swapper swappee))]))

;; triangulate : (listof (listof number)) -> (listof (listof number))
(define (triangulate lon)
  (cond
   [(empty? lon) empty]
   [(zero? (first (first lon))) (triangulate (swap (first (rest lon)) lon))]
   [else (cons (first lon) (triangulate (subtract-from-each (first lon) (rest lon))))]))

;; subtract-from-each : (listof number) (listof (listof number)) -> (listof (listof number))
;; Subtracts first list of numbers from all other list of numbers
(define (subtract-from-each row list-of-rows)
  (cond
   [(empty? list-of-rows) empty]
   [else (cons (subtract row (first list-of-rows))
               (subtract-from-each row (rest list-of-rows)))]))

;; subtract: (listof number) (listof number) -> (listof number)
;; Subtracts first list from the second and returns a list with
;; first 0 omitted.
(define (subtract l1 l2)
  (cond
   [(empty? l1) l2]
   [else (local ((define (equalizer x) (* x (/ (first l2) (first l1))))
                 ;; subtract-list : (listof number) (listof number) -> (listof number)
                 ;; Subtracts two lists.
                 (define (subtract-list l1 l2)
                   (cond
                    [(and (empty? l1) (empty? l2)) empty]
                    [(and (cons? l1) (cons? l2)) (cons (- (first l2) (first l1)) (subtract-list (rest l1) (rest l2)))]
                    [else (error 'subtract-list "Cannot subtract list with different length")])))
           (rest (subtract-list (map equalizer l1) l2)))]))

;; TESTS

(equal? (swap (list 4 5) (list (list 2 3) (list 4 5) (list 3 1)))
        (list (list 4 5) (list 2 3) (list 3 1)))

(equal? (triangulate '((0 -5 -5) (-8 -4 -12))) '((-8 -4 -12) (-5 -5)))
