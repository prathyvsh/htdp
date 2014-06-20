#|
;;TEMPLATE
(define (convert digit-list)
  (cond
    [(empty? digit-list) ...]
    [... (first digit-list) ... (convert (rest digit-list)) ...]))
 |#

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
  (cond
  [(< (convert list-of-digits) target) 'TooSmall]
  [(= (convert list-of-digits) target) 'Perfect]
  [(> (convert list-of-digits) target) 'TooLarge]
  ))

;; TESTS
(= (convert (cons 2 (cons 1 empty))) 12)
(= (convert (cons 3 (cons 2 (cons 1 empty)))) 123)
(= (convert (cons 4 (cons 5 (cons 6 empty))))  654)

(guess-with-gui-list 4 check-guess-for-list)
