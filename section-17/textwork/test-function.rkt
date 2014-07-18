#lang racket
(require lang/htdp-beginner-abbr)

;; test-hours->wages : list-of-numbers list-of-numbers list-of-numbers -> test-result
;; to test hours->wages
(define (test-hours->wages a-list another-list expected-result)
(cond
[(list=? (hours->wages a-list another-list) expected-result)
true] [else
     (list "bad test result:" a-list another-list expected-result)]))

;; hours->wages : list-of-numbers list-of-numbers  ->  list-of-numbers
;; to construct a new list by multiplying the corresponding items on
;; ASSUMPTION: the two lists are of equal length 
;; alon1 and alon2
(define (hours->wages alon1 alon2)
  (cond
    ((empty? alon1) empty)
    (else (cons (weekly-wage (first alon1) (first alon2))
                (hours->wages (rest alon1) (rest alon2))))))

;; weekly-wage : number number  ->  number
;; to compute the weekly wage from pay-rate and hours-worked
(define (weekly-wage pay-rate hours-worked)
  (* pay-rate hours-worked))

;; list=? : list-of-numbers list-of-numbers  ->  boolean
;; to determine whether a-list and another-list 
;; contain the same numbers in the same order
(define (list=? a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [(cons? a-list)
     (and (cons? another-list)
          (and (= (first a-list) (first another-list))
               (list=? (rest a-list) (rest another-list))))]))

;; TESTS
(test-hours->wages
(cons 5.65 (cons 8.75 empty)) (cons 40 (cons 30 empty))
(cons 226.0 (cons 262.5 empty)))

(test-hours->wages
(cons 5.65 (cons 8.75 empty)) (cons 40 (cons 30 empty))
(cons 220.0 (cons 262.5 empty)))
