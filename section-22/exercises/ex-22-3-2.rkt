#lang racket
(require lang/htdp-intermediate)
(require htdp/gui)

;; MODEL
;; A contact is
;; (make-contact symbol number)
(define-struct contact (name phone))

;; lookup-name : symbol (listof contact)
(define (lookup-name name aloc)
  (local ((define phone-lookup (lookuper symbol=? contact-name contact-phone)))
    (phone-lookup name aloc)))

;; lookup-phone : number (listof contact)
(define (lookup-phone number aloc)
  (local ((define phone-lookup (lookuper = contact-phone contact-name)))
    (phone-lookup number aloc)))

;; lookup : (contact contact) struct-accessor symbol/number (listof contact) -> contact or false
(define (lookuper cmp compare-element extract-element)
  (local ((define (lookup value aloc)
            (cond
             [(empty? aloc) false]
             [(cmp (compare-element (first aloc)) value) (extract-element (first aloc))]
             [else (lookup value (rest aloc))]))) lookup))


(define shankar (make-contact 'Shankar 9233223393))
(define vikram (make-contact 'Vikram 8223232889))
(define amy (make-contact 'Amy 4232342344))
(define address-book (list shankar vikram amy))

;; VIEW
(define query-field (make-text "Name/Phone"))

(define query-result-message (make-message "search"))

;; CONTROLLER
(define (display-message val)
  (cond
   [(false? val) "not found"]
   [else (cond
          [(number? val) (number->string val)]
          [(symbol? val) (symbol->string val)])]))



;; lookup-callback : event -> string
;; On receiving a click returns the contact record matching the query
(define (lookup-callback x)
  (local ((define query (text-contents query-field))
          (define number-query (string->number query))
    (define query-result 
    (cond
     [(false? number-query) (lookup-name (string->symbol query) address-book)]
     [else (lookup-phone number-query address-book)])))
    (draw-message query-result-message (display-message query-result))))


(create-window (list (list query-field (make-button "Lookup" lookup-callback)) (list query-result-message)))
