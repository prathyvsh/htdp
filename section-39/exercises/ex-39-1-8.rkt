#lang racket
(require lang/htdp-advanced)
(require htdp/gui)

;; make-address-book : string  ->  address-book
;; to create a function that manages all the services for a hidden address book
(define (make-address-book title)
  (local ((define-struct entry (name number))
	  ;; address-book : (listof (list name number))
	  ;; to maintain a list of name-phone number associations
	  (define address-book empty)
	  
          ;; add-to-address-book : symbol number void
	  ;; effect: to add a name-phone number association to address-book
          (define (add-to-address-book name phone)
            (set! address-book (cons (make-entry name phone) address-book)))
	  
          ;; lookup : symbol (listof (list symbol number))  ->  number or false
          ;; to lookup the phone number for name in address-book
          (define (lookup name ab)
            (cond
             [(empty? ab) false]
             [else (cond
                    [(symbol=? (entry-name (first ab)) name)
                     (entry-number (first ab))]
                    [else (lookup name (rest ab))])]))
          
          ;; service-manager : address-book object
          ;; to manage addition to, and searches in, the address book 
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'add)
              add-to-address-book]
             [(symbol=? msg 'search)
              (lambda (name)
                (lookup name address-book))]
             [else (error 'address-book "message not understood")])))
    service-manager))

;; friends : an address book
;; to maintain an address book for friends 
(define friends
  (make-address-book "Friends of Charles"))

;; business : an address book
;; to maintain an address book for business colleagues
(define business
  (make-address-book "Colleagues @ Rice, Inc."))


;; gui-for-address-book : (listof string) -> (void)
;; Creates an address book for each of the given names
;; and displays a GUI with a choice menu.
(define (gui-for-address-book book-names)
  (local ((define address-books (build-address-books book-names))
          (define name-field (make-text "Enter name:"))
          (define phone-field (make-text "Enter number:"))
          (define choice-field (make-choice book-names))
          (define (current-choice) (list-ref address-books (choice-index choice-field)))
          (define (name-query) (string->symbol (text-contents name-field)))
          (define (phone-query) (string->number (text-contents phone-field)))
          (define search-btn (make-button "Search" (lambda (x) (echo-message (((current-choice) 'search) (name-query))))))
          (define add-btn (make-button "Add Entry"
                                       (lambda (x) (cond
                                                    =                                      [(or (equal? (text-contents name-field) "")
                                                                                                (equal? (text-contents phone-field) ""))
                                                                                            (echo-message "Please enter valid name and phone number")]
                                                    [else (echo-message (begin (((current-choice) 'add) (name-query) (phone-query)) true))]))))
          (define help-label (make-message "Welcome!"))
          (define (echo-message e) (local ((define result-message (cond
                                                                   [(false? e) "Person not found"]
                                                                   [(equal? e true) "Person added"]
                                                                   [(number? e) (number->string e)]
                                                                   [else e]))) (draw-message help-label result-message))))
    (create-window (list (list (make-message "Search Address Book: ") choice-field)
                         (list name-field phone-field search-btn add-btn)
                         (list help-label)))))

;; build-address-books : (listof string) -> (listof address-book)
;; Creates a list of address-books from the given name.
(define (build-address-books books) (map make-address-book books))

(gui-for-address-book (list "friends" "business"))
