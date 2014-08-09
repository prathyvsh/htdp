#lang racket
(require lang/htdp-intermediate-lambda)

;; create-matrix :[N>=1] (listof number) -> (listof (listof number))
;; Takes in a list of numbers and splits it up into rows.
;; ASSUMPTION : lon has n^2 elements
(define (create-matrix n lon)
  (local ((define (prefix n base combine afile)
            (cond
             [(empty? afile) empty]
             [else (cond [(= n 0) (base afile)]
                         [else (combine (first afile) (prefix (sub1 n) base combine (rest afile)))])]))

          ;; remove-row : [N>=1] (listof number)  ->  (listof number)
          ;; to compute the suffix of lon behind the first occurrence of NEWLINE
          (define (remove-row n lon)
            (prefix n (lambda (x) x) (lambda (x y) y) lon))

          ;; first-line : [N>=1] (listof number)  ->  (listof number)
          ;; to compute the prefix of lon up to the first occurrence of NEWLINE
          (define (first-line n lon)
            (prefix n (lambda (x) empty) cons lon)))
    (cond
     [(empty? lon) empty]
     [else (local ((define a-row (first-line n lon)))
             (cons a-row (create-matrix n (remove-row n lon))))])))


(equal? (create-matrix 2 (list 1 2 3 4)) (list (list 1 2) (list 3 4)))
(equal? (create-matrix 1 (list 1 2)) (list (list 1) (list 2)))
(equal? (create-matrix 3 (list 5 9 3 4 8 2 2 1 3)) (list (list 5 9 3)
                                                         (list 4 8 2)
                                                         (list 2 1 3)))
