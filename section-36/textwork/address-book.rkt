;; Data Def.: lists of arbitrary length: (listof X), lists of two items: (list Y Z)

;; State Variable:
;; address-book : (listof (list symbol number))

;; to keep track of pairs of names and phone numbers
(define address-book empty)

;; Contract: add-to-address-book : symbol number -> void

;; Purpose: the function always produces (void)

;; Effect: to add (list name phone) to the front of address-book

;; Header:
;; (define (add-to-address-book name phone) ...)

;; Examples:
;; if address-book is empty and we evaluate
;; (add-to-address-book 'Adam 1)
;; address-book is (list (list 'Adam 1)).
;; if address-book is (list (list 'Eve 2)) and we evaluate
;; (add-to-address-book 'Adam 1), address-book is (list (list 'Adam 1) (list 'Eve 2)).

;; if address-book is (list E-1 ... E-2) and we evaluate
;; (add-to-address-book 'Adam 1), address-book is (list (list 'Adam 1) E-1 ... E-2).

;; Template: omitted
;; Definition:
(define (add-to-address-book name phone)
(set! address-book (cons (list name phone) address-book)))

;; Tests:
(begin (set! address-book empty) (add-to-address-book 'Adam 1) (equal? '((Adam 1)) address-book))
