#lang racket
(require lang/htdp-intermediate-lambda)

;; solve : (listof (listof number) -> (listof number)
;; Solves a system of triangulated equations
(define (solve eqns)
  (cond [(empty? eqns) empty]
        [else (local ((define eq (first eqns))
                      (define next-solution (solve (rest eqns))))
                (cond
                 [(= (length eq) 2) (list (/ (second eq) (first eq)))]
                 [else (cons (- (/ (evaluate (rest eq) next-solution) (first eq))) next-solution)]))]))

;; evaluate : (listof number) (listof number) -> number
;; Evaluates rest of left hand side of an equation and subtracts rhs from it.
(define (evaluate rhs solution)
  (cond [(and (empty? solution) (empty? (rest rhs))) (- (first rhs))]
        [(or (and (empty? solution) (cons? (rest rhs)))
             (and (cons? solution) (empty? (rest rhs)))) (error 'evaluate "Please provide a valid rhs and solution")]
        [else (+ (* (first rhs) (first solution)) (evaluate (rest rhs) (rest solution)))]))

;; triangulate : (listof (listof number)) -> (listof (listof number))
;; Triangulates a system of equations
(define (triangulate lon)
  (local (
          ;; swap : (listof number) (listof (listof number))
          ;; Swaps given row with the next row in the list of numbers
          (define (swap swapper swappee)
            (cond
             [(empty? swappee) empty]
             [else (cons swapper (remove swapper swappee))])))
    
    (cond [(empty? lon) empty]
          [(and (zero? (first (first lon))) (zero? (first (second lon))))
           (error 'triangulate "This system of equations can't be solved")]
          [(zero? (first (first lon)))
           (triangulate (swap (first (rest lon)) lon))]
          [else (cons (first lon) (triangulate (subtract-from-each (first lon) (rest lon))))])))

;; subtract-from-each : (listof number) (listof (listof number)) -> (listof (listof number))
;; Subtracts first list of numbers from all other list of numbers
(define (subtract-from-each row list-of-rows)
  (local (
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
                     (rest (subtract-list (map equalizer l1) l2)))]))) 
    (cond [(empty? list-of-rows) empty]
          [else (cons (subtract row (first list-of-rows))
                      (subtract-from-each row (rest list-of-rows)))])))

;; TESTS
(equal? (evaluate (list 9 21) (list 2)) -3)
(equal? (evaluate (list -8 -4 -12) (list 1 1)) 0)

(equal? (solve '((1 2))) '(2))
(equal? (solve '((3 9 21) (1 2))) '(1 2))

(equal? (solve (triangulate '((2 3 3 8) (2 3 -2 3) (4 -2 2 4)))) '(1 1 1))

(equal? (solve (triangulate '((2 2 3 10)
                              (2 5 12 31)
                              (4 1 -2 1)))) '(1 1 2))

(equal? (solve (triangulate '((2 1 -1 8)
                              (-3 -1 2 -11)
                              (-2 1 2 -3)))) '(2 3 -1))


;; One pitfall with this solution is that it fails to find solution in the case of:
;; '((1 3 1 9) (1 1 -1 1) (3 11 5 35))
;; where the reduction yields 0 as the coefficient of the last term in the equation i.e
;; in ax + by + cz, c = 0.
