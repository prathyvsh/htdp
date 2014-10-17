#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
(define (check-range1? temperature-list)
  (cond
    [(empty? temperature-list) ...]
    [... (first temperature-list) ... (check-range1? (rest temperature-list)) ...]))

|#

;; HEADER
;; check-range1? temperature-list -> boolean
;; Determines if all temperatures in temperature-list is between 5 and
;; 95
(define (check-range1? temperature-list)
  (cond
    [(empty? temperature-list) true]
    [else (and (between? 5 95 (first temperature-list)) (check-range1? (rest temperature-list)))]))

;; check-range? temperature-list number number -> boolean
;; Determines if all temperatures in temperature-list is between start
;; and end
(define (check-range? temperature-list start end)
  (cond
    [(empty? temperature-list) true]
    [else (and (between? start end (first temperature-list)) (check-range? (rest temperature-list) start end))]))


;; between : number number number -> boolean
;; Determines if point is between start and end both exclusive.
(define (between? start end point)
  (< start point end))

;; TESTS
(boolean=? (check-range1? (cons 20 empty)) true)
(boolean=? (check-range1? (cons 25 (cons 100 empty))) false)
(boolean=? (check-range1? (cons 90 (cons 40 (cons 5 empty)))) false)
(boolean=? (check-range1? (cons 1 (cons 95 empty))) false)
(boolean=? (check-range1? (cons 20 (cons 30 (cons 45 (cons 94 empty))))) true)
(boolean=? (check-range1? (cons 4 empty)) false)

(boolean=? (check-range? (cons 20 empty) 5 95) true)
(boolean=? (check-range? (cons 25 (cons 100 empty)) 5 95) false)
(boolean=? (check-range? (cons 90 (cons 40 (cons 5 empty))) 5 95) false)
(boolean=? (check-range? (cons 90 (cons 40 (cons 5 empty))) 4 100) true)
(boolean=? (check-range? (cons 10 (cons 30 (cons 5 empty))) 10 30) false)
(boolean=? (check-range? (cons 11 (cons 29 (cons 5 empty))) 4 30) true)
