#lang racket
(require lang/htdp-beginner)

;; checked-hours->wages : list-of-numbers -> list-of-numbers
;; Checked hours->wages function that avoids input of a list
;; containing hours greater than 100
(define (checked-hours->wages alon)
  (cond
    [(has-more-than-100? alon) (error 'checked-hours->wages "Too many hours")]
    [else (hours->wages alon)]))

;; has-more-than-100? : list-of-numbers -> boolean
(define (has-more-than-100? a-list)
  (cond
    [(empty? a-list) false]
    [else (or (> (first a-list) 100) (has-more-than-100? (rest a-list)))]))

;; hours->wages : list-of-numbers  ->  list-of-numbers
;; to create a list of weekly wages from a list of weekly hours (alon)
(define (hours->wages alon)
  (cond
    [(empty? alon) empty]
    [else (cons (wage (first alon)) (hours->wages (rest alon)))]))

;; wage : number  ->  number
;; to compute the total wage (at $12 per hour)
;; of someone who worked for h hours
(define (wage h)
  (* 12 h))

;; TESTS
(define legal (cons 32 (cons 25 (cons 99 empty))))
(define illegal (cons 32 (cons 23 (cons 4 (cons 150 empty)))))

(checked-hours->wages legal)
(checked-hours->wages illegal)
