#lang racket
(require lang/htdp-beginner-abbr)

;; A phone-record is
;; (make-phone-record symbol number)
(define-struct phone-record (name number))

;; zip : list-of-names list-of-numbers -> list-of-phone-record
;; Compiles the list of names and list of numbers into a list of phone
;; records.
;; ASSUMPTION: Both list of names and list of numbers have the same
;; length and contains the entries in a one to one manner.
(define (zip names numbers)
  (cond
    [(empty? names) empty]
    [else (cons (make-phone-record (first names) (first numbers))
                (zip (rest names) (rest numbers)))]))

;; TESTS
(check-expect (zip empty empty) empty)
(check-expect (zip (list 'James 'Peter 'Kane) (list 3222 3523 2352)) (list (make-phone-record 'James 3222)
                                                                           (make-phone-record 'Peter 3523)
                                                                           (make-phone-record 'Kane 2352)))
