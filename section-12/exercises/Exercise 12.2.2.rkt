#lang racket
(require lang/htdp-beginner)

;; search : number list-of-numbers  ->  boolean
;; Determines if n occurs in alon
(define (search n alon)
  (cond
    [(empty? alon) false]
    [else (or (= (first alon) n) (search n (rest alon)))]))

;; search-sorted : number list-of-sorted-numbers -> boolean
;; Determines if n occures in aslon
(define (search-sorted n aslon)
  (cond
    [(empty? aslon) false]
    [else (cond
            [(= n (first aslon)) true]
            [(< n (first aslon)) false]
            [else (search-sorted n (rest aslon))])]))

;; TESTS
(boolean=? (search-sorted 2323 empty) false)
(boolean=? (search-sorted 5 (cons 1 (cons 2 (cons 3 (cons 4 empty))))) false)
(boolean=? (search-sorted 3 (cons 1 (cons 3 (cons 7 empty)))) true)
