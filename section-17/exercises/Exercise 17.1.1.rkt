#lang racket
(require lang/htdp-beginner-abbr)

;; replace-eol-with : list-of-numbers list-of-numbers  ->  list-of-numbers
;; to construct a new list by replacing empty in alon1 with alon2
(define (replace-eol-with alon1 alon2)
  (cond
    ((empty? alon1) alon2)
    (else (cons (first alon1) (replace-eol-with (rest alon1) alon2)))))

;; our-append : list list list -> list
(define (our-append l1 l2 l3)
  (replace-eol-with (replace-eol-with l1 l2) l3))

;; TESTS
(check-expect (our-append (list 'a) (list 'b 'c) (list 'd 'e 'f)) (list 'a 'b 'c 'd 'e 'f))
