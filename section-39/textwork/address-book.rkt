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

