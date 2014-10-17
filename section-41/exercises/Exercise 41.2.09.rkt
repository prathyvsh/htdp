#lang racket
(require lang/htdp-advanced)

;; An entry is
(define-struct entry (name number))

;; An address-book is

;; the empty list, empty, or
;; (cons an-e an-ab)

;; change-number! : symbol number address-book  ->  void
;; effect: to modify the first entry for name in ab so that its
;; number field is phone
(define (change-number! name phone ab)
  (cond
   [(empty? ab) (error 'change-number! "name not in list")]
   [else (cond
          [(symbol=? (entry-name (first ab)) name)
           (set-entry-number! (first ab) phone)]
          [else 
           (change-number! name phone (rest ab))])]))

;; test-change-number : name number address-book -> void
;; Changes a number from the given addressbook with given name.
(define (test-change-number name new-number ab)
  (begin (change-number! name new-number ab)
         (cond
          [(empty? ab) false] 
          [(symbol=? (entry-name (first ab)) name)
           (= new-number (entry-number (first ab)))]
          [else (test-change-number name new-number (rest ab))])))

;; TESTS
(define john (make-entry 'John 23))
(define george (make-entry 'George 42))
(define martha (make-entry 'Martha 21))
(define home (list john george martha))

(test-change-number 'John 21 home)
(test-change-number 'George 88 home)
(test-change-number 'Martha 42 home)
