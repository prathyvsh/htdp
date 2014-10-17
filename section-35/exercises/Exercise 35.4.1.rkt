#lang racket
(require lang/htdp-intermediate-lambda)

(define address-book empty)

;; add-to-address-book : symbol number -> void
(define (add-to-address-book name phone)
  (set! address-book (cons (list name phone) address-book)))

;; lookup : symbol (listof (list symbol number)) -> number or false
;; to lookup the phone number for name in ab
(define (lookup name ab)
  (cond
   [(empty? ab) false]
   [else (cond
          [(symbol=? (first (first ab)) name)
           (second (first ab))]
          [else (lookup name (rest ab))])]))

;; remove : symbol -> void
;; Removes the entry with the given name from address book.
(define (remove-name name)
  (set! address-book (remove (assf (lambda (x) (symbol=? name x)) address-book) address-book)))

;; TESTS

(begin (add-to-address-book 'Adam 1)
       (add-to-address-book 'Eve 2)
       (add-to-address-book 'Chris 6145384))

(remove-name 'Adam)
(equal? address-book (list '(Chris 6145384) '(Eve 2)))
