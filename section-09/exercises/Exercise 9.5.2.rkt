#lang racket
(require lang/htdp-beginner)

#|
;; TEMPLATE
(define (how-many-symbols symbol-list)
  (cond
    [(empty? symbols-list) ...]
    [... (first symbols-list) ... (rest symbols-list)]))
|#

;; HEADER
;; how-many-symbols : list-of-symbols -> number
;; Counts how many symbols are there in the list
(define (how-many-symbols symbol-list)
  (cond
    [(empty? symbol-list) 0]
    [else (+ 1 (how-many-symbols (rest symbol-list)))]))

;; TESTS
(= (how-many-symbols (cons 'empty (cons 'hello empty))) 2)
(= (how-many-symbols (cons 'ball (cons 'balloon (cons 'orange empty)))) 3)

#|
;; TEMPLATE
(define (how-many-numbers numbers-list)
  (cond
    [(empty? numbers-list) ...]
    [... (first numbers-list) ... (rest numbers-list)]))
|#

;; HEADER
;; how-many-symbols : list-of-symbols -> number
;; Counts how many symbols are there in the list
(define (how-many-numbers number-list)
  (cond
    [(empty? number-list) 0]
    [else (+ 1 (how-many-numbers (rest number-list)))]))

;; TESTS
(= (how-many-symbols (cons 3 (cons 3 empty))) 2)
(= (how-many-symbols (cons 4 (cons 5 (cons 6 empty)))) 3)

;; Only difference is in the naming of the function.
