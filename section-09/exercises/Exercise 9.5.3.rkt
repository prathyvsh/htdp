#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
(define (dollar-store? price-list)
  (cond
    [(empty? pricelist) ...]
    [(... (first price-list) ... (dollar-store? (rest price-list))) ...]))
|#

;; HEADER
;; dollar-store? : list-of-prices -> boolean
;; Checks if all the prices in the price-list are less than 1
(define (dollar-store? price-list)
  (cond
    [(empty? price-list) true]
    [else (and (< (first price-list) 1) (dollar-store? (rest price-list)))]
    ))

;; HEADER
;;general-dollar-store? : list-of-prices -> boolean
;; Checks if all the prices in the pricelist are below threshold
(define (general-dollar-store? price-list threshold)
  (cond
    [(empty? price-list) true]
    [else (and (< (first price-list)  threshold) (general-dollar-store? (rest price-list) threshold))]
    ))

;; TESTS
(boolean=? (dollar-store? empty) true)
(boolean=? (not (dollar-store? (cons .75 (cons 1.95 (cons .25 empty))))) true)
(boolean=? (dollar-store? (cons .15 (cons .05 (cons .25 empty)))) true)

(boolean=? (general-dollar-store? empty 1) true)
(boolean=? (not (general-dollar-store? (cons .75 (cons 1.95 (cons .25 empty))) 1)) true)
(boolean=? (general-dollar-store? (cons .75 (cons 1.95 (cons .25 empty))) 1) false)
(boolean=? (general-dollar-store? (cons .15 (cons .05 (cons 3.25 empty))) 5) true)
