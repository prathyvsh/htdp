#lang racket
;; sort : list-of-numbers -> list-of-numbers
(define (sort alon)
  (local ((define (sort alon)
            (cond
             [(empty? alon) empty]
             [(cons? alon) (insert (first alon) (sort (rest alon)))])
            (define (insert an alon)
              (cond
               [(empty? alon) (list an)]
               [else (cond
                      [(> an (list an)) (cons an alon)]
                      [else (cons (first alon) (insert an (rest alon)))])]))))
    (sort alon)))

;;(sort (list 2 1 3))

;; sort : list-of-numbers -> list-of-numbers
(define (sort (list 2 1 3))
  (local ((define (sort1 (list 2 1 3))
            (cond
             [(empty? (list 2 1 3)) empty]
             [(cons? (list 2 1 3)) (insert (first (list 2 1 3)) (sort1 (rest (list 2 1 3))))])
            (define (insert an (list 2 1 3))
              (cond
               [(empty? (list 2 1 3)) (list an)]
               [else (cond
                      [(> an (list an)) (cons an (list 2 1 3))]
                      [else (cons (first (list 2 1 3)) (insert an (rest (list 2 1 3))))])]))))
    (sort1 (list 2 1 3))))

(define (sort1 (list 2 1 3))
  (cond
   [(empty? (list 2 1 3)) empty]
   [(cons? (list 2 1 3)) (insert1 (first (list 2 1 3)) (sort1 (rest (list 2 1 3))))]))

(define (insert1 an (list 2 1 3))
  (cond
   [(empty? (list 2 1 3)) (list an)]
   [else (cond
          [(> an (list an)) (cons an (list 2 1 3))]
          [else (cons (first (list 2 1 3)) (insert1 an (rest1 (list 2 1 3))))])]))

(sort1 (list 2 1 3)))

(sort1 (list 2 1 3))
(cond
 [(empty? (list 2 1 3)) empty]
 [(cons? (list 2 1 3)) (insert1 (first (list 2 1 3))) (sort1 (rest (list 2 1 3)))])

(cond
 [false empty]
 [(cons? (list 2 1 3)) (insert1 (first (list 2 1 3))) (sort1 (rest (list 2 1 3)))])

(insert1 2 (sort1 (rest (list 2 1 3))))

;;(equal? (sort (list 1)) (sort (list 2)))
;; sort : list-of-numbers -> list-of-numbers

(equal? (  (local ((define (sort alon)
                     (cond
                      [(empty? alon) empty]
                      [(cons? alon) (insert (first alon) (sort (rest alon)))])
                     (define (insert an alon)
                       (cond
                        [(empty? alon) (list an)]
                        [else (cond
                               [(> an (list an)) (cons an alon)]
                               [else (cons (first alon) (insert an (rest alon)))])]))))
             (sort (list 1)))) (   (local ((define (sort alon)
                                             (cond
                                              [(empty? alon) empty]
                                              [(cons? alon) (insert (first alon) (sort (rest alon)))])
                                             (define (insert an alon)
                                               (cond
                                                [(empty? alon) (list an)]
                                                [else (cond
                                                       [(> an (list an)) (cons an alon)]
                                                       [else (cons (first alon) (insert an (rest alon)))])]))))
                                     (sort (list 2)))))


(define (sort1 alon)
  (cond
   [(empty? alon) empty]
   [(cons? alon) (insert1 (first alon) (sort1 (rest alon)))]))

(define (insert1 an alon)
  (cond
   [(empty? alon) (list an)]
   [else (cond
          [(> an (list an)) (cons an alon)]
          [else (cons (first alon) (insert1 an (rest alon)))])]))

(equal? (sort1 (list 1))
        ((local ((define (sort alon)
                   (cond
                    [(empty? alon) empty]
                    [(cons? alon) (insert (first alon) (sort (rest alon)))])
                   (define (insert an alon)
                     (cond
                      [(empty? alon) (list an)]
                      [else (cond
                             [(> an (list an)) (cons an alon)]
                             [else (cons (first alon) (insert an (rest alon)))])]))))
           (sort (list 2)))))

(equal? (cond
         [(empty? (list 1)) empty]
         [(cons? (list 1)) (insert1 (first (list 1)) (sort (rest (list 1))))])
        ((local ((define (sort alon)
                   (cond
                    [(empty? alon) empty]
                    [(cons? alon) (insert (first alon) (sort (rest alon)))])
                   (define (insert an alon)
                     (cond
                      [(empty? alon) (list an)]
                      [else (cond
                             [(> an (list an)) (cons an alon)]
                             [else (cons (first alon) (insert an (rest alon)))])]))))
           (sort (list 2)))))

(equal? (insert1 1 (sort (rest (list 1))))
        ((local ((define (sort alon)
                   (cond
                    [(empty? alon) empty]
                    [(cons? alon) (insert (first alon) (sort (rest alon)))])
                   (define (insert an alon)
                     (cond
                      [(empty? alon) (list an)]
                      [else (cond
                             [(> an (list an)) (cons an alon)]
                             [else (cons (first alon) (insert an (rest alon)))])]))
                   (sort (list 2)))))))

(equal? (insert 1 (sort empty)) ((local ((define (sort alon)
                                           (cond
                                            [(empty? alon) empty]
                                            [(cons? alon) (insert (first alon) (sort (rest alon)))]
                                            (define (insert an alon)
                                              (cond
                                               [(empty? alon) (list an)]
                                               [else (cond
                                                      [(> an (list an)) (cons an alon)]
                                                      [else (cons (first alon) (insert an (rest alon)))])]))
                                            (sort (list 2))))))))
;; skipping to next sort
(equal? (list 1) (sort2 (list 2)))
(define (sort2 alon)
  (cond
   [(empty? alon) empty]
   [(cons? alon) (insert2 (first alon) (sort2 (rest alon)))]))

(define (insert2 an alon)
  (cond
   [(empty? alon) (list an)]
   [else (cond
          [(> an (list an)) (cons an alon)]
          [else (cons (first alon) (insert2 an (rest alon)))])]))

(equal? (list 1) (cond
                  [(empty? (list 2)) empty]
                  [(cons? (list 2)) (insert2 (first (list 2) (sort2 (rest (list 2)))))]))

(equal? (list 1) (insert2 2 (sort2 (rest (list 2)))))
(equal? (list 1) (insert2 2 empty))
(equal? (list 1) (list 2))
false
