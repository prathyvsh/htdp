#lang racket
(require lang/htdp-beginner)

;;general-dollar-store? : list-of-prices -> boolean
;; Checks if all the prices in the price-list are below threshold
(define (general-dollar-store? price-list threshold)
  (cond
    [(empty? price-list) true]
    [else (and (< (first price-list)  threshold) (general-dollar-store? (rest price-list) threshold))]
    ))

;; create-prices takes in a number a produces corresponding
;; number of prices between $0.10 and $10.00
;; create-prices number -> list-of-number
(define (create-prices number)
  (cond
    [(zero? number) empty]
    [else (cons (/ (random-n-m 1 100) 10) (create-prices (sub1 number)))]))


;; random-n-m : integer integer -> integer
;; Creates a number between n and m
;; Assume n < m
(define (random-n-m n m)
  (+ (random (- m n)) n))

;; TESTS
"Lists produced should have value between 0.1 and 10"
(create-prices 0)
(create-prices 1)
(create-prices 2)

(general-dollar-store? (create-prices 20) 10)
(general-dollar-store? (create-prices 30) 10)
(general-dollar-store? (create-prices 40) 10)
