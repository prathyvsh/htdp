#lang racket
(require lang/htdp-intermediate-lambda)

;; to10 : (listof number) -> number
;; Converts the list of numbers to it's decimal
;; representation
(define (to10 lon)
  ;; acc stands for the number version of digits so far
  (local ((define (to10-acc lon acc)
            (cond
             [(empty? lon) acc]
             [(empty? (rest lon)) (+ acc (first lon))]
             [else (to10-acc (rest lon) (+ acc (* (expt 10 (sub1 (length lon))) (first lon))))])))
    (to10-acc lon 0)
    ))

;; to10-general : number (listof number) -> number
;; Converts the list of numbers to it's chosen
;; representation
(define (to10-general base lon)
  ;; acc stands for the number version of digits so far
  (local ((define (to10-acc lon acc)
            (cond
             [(empty? lon) acc]
             [(empty? (rest lon)) (+ acc (first lon))]
             [else (to10-acc (rest lon) (+ acc (* (expt base (sub1 (length lon))) (first lon))))])))
    (to10-acc lon 0)))

;; TESTS
(equal? (to10 (list 1 0 2)) 102)
(equal? (to10-general 10 (list 1 0 2)) 102)
(equal? (to10-general 8 (list 1 0 2)) 66)
(equal? (to10-general 2 (list 1 0 1)) 5)

