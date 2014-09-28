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
