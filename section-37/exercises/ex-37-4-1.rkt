#lang racket
(require lang/htdp-advanced)
(require htdp/guess)

#|
;;TEMPLATE
(define (convert digit-list)
  (cond
    [(empty? digit-list) ...]
    [... (first digit-list) ... (convert (rest digit-list)) ...]))
 |#

;; STATE VARIABLES
;; click-count : number
;; Keeps track of the number of times the button
;; was pressed in a session
(define click-count 0)

;; init-program -> void
;; Initializes the program
(define (init-program)
  (set! click-count 0))

;; HEADER
;; convert : digit-list -> boolean
;; Converts digit-list to a number by considering the first list to
;; be the least significant
(define (convert digit-list)
  (cond
    [(empty? digit-list) 0]
    [else (+ (first digit-list) (* (convert (rest digit-list)) 10))]))


;; check-guess-for-list number number -> symbol
(define (check-guess-for-list list-of-digits target)
  (begin (set! click-count (add1 click-count))
  (cond
  [(< (convert list-of-digits) target) 'TooSmall]
  [(= (convert list-of-digits) target) 'Perfect]
  [(> (convert list-of-digits) target) 'TooLarge]
  )))

;; TESTS
(= (convert (cons 2 (cons 1 empty))) 12)
(= (convert (cons 3 (cons 2 (cons 1 empty)))) 123)
(= (convert (cons 4 (cons 5 (cons 6 empty))))  654)

(init-program)
(guess-with-gui-list 4 check-guess-for-list)
