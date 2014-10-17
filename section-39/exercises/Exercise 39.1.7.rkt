;; friends : an address book
;; to maintain an address book for friends 
(define friends
  (make-address-book "Friends of Charles"))

;; business : an address book
;; to maintain an address book for business colleagues
(define business
  (make-address-book "Colleagues @ Rice, Inc."))

;; TOP LEVEL DEFINITIONS

(define-struct entry@friends (name number))
(define address-book@friends empty)
(define (add-to-address-book@friends name phone)
  (set! address-book@friends (cons (make-entry@friends name phone) address-book@friends)))

;; lookup@friends : symbol (listof (list symbol number))  ->  number or false
;; to lookup@friends the phone number for name in address-book@friends
(define (lookup@friends name ab)
  (cond
   [(empty? ab) false]
   [else (cond
          [(symbol=? (entry@friends-name (first ab)) name)
           (entry@friends-number (first ab))]
          [else (lookup@friends name (rest ab))])]))

;; service-manager@friends : address-book@friends object
;; to manage addition to, and searches in, the address book 
(define (service-manager@friends msg)
  (cond
   [(symbol=? msg 'add)
    add-to-address-book@friends]
   [(symbol=? msg 'search)
    (lambda (name)
      (lookup@friends name address-book@friends))]
   [else (error 'address-book@friends "message not understood")])))
service-manager@friends)

(define-struct entry@business (name number))
(define address-book@business empty)
(define (add-to-address-book@business name phone)
  (set! address-book@business (cons (make-entry@business name phone) address-book@business)))

;; lookup@business : symbol (listof (list symbol number))  ->  number or false
;; to lookup@business the phone number for name in address-book@business
(define (lookup@business name ab)
  (cond
   [(empty? ab) false]
   [else (cond
          [(symbol=? (entry@business-name (first ab)) name)
           (entry@business-number (first ab))]
          [else (lookup@business name (rest ab))])]))

;; service-manager@business : address-book@business object
;; to manage addition to, and searches in, the address book 
(define (service-manager@business msg)
  (cond
   [(symbol=? msg 'add)
    add-to-address-book@business]
   [(symbol=? msg 'search)
    (lambda (name)
      (lookup@business name address-book@business))]
   [else (error 'address-book@business "message not understood")])))
service-manager@business)

;; State after execution

((friends 'add) 'Bill 2)
((friends 'add) 'Sally 3)
((friends 'add) 'Dave 4)
((business 'add) 'Emil 5)
((business 'add) 'Faye 18)

(define address-book@friends (list (entry 'Bill 2) (entry 'Sally 3) (entry 'Dave 2)))
(define address-book@business (list (entry 'Emil 5) (entry 'Faye 18)))

((friends 'search) 'Bill)

;;

  (cond
   [(symbol=? 'search 'add)
    add-to-address-book@friends]
   [(symbol=? msg 'search)
    (lambda (name)
      (lookup@friends name address-book@friends))]
   [else (error 'address-book@friends "message not understood")])))
service-manager@friends)

;;

  (cond
   [(symbol=? 'search 'search)
    (lambda (name)
      (lookup@friends name address-book@friends))]
   [else (error 'address-book@friends "message not understood")])))

;;

((lambda (name) (lookup@business name address-book@business)) 'Bill)

;;

(lookup@business 'Bill (list (entry 'Bill 2) (entry 'Sally 3) (entry 'Dave 2)))

;;

(entry 'Bill 2)
