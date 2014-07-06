;;A Web-page (short: WP) is a structure:
;; (make-wp h p) 
;; where h is a symbol and p is a (Web) document.
(define-struct wp (header body))

;;A (Web) document is either

;;empty

;;(cons s p)
;;where s is a symbol and p is a document

;;(cons w p)
;;where w is a Web page and p is a document

#|

;; TEMPLATE
(define (web-page-template wp)
  ... (header-wp wp) ...
  ... (web-document-template (body-wp wp)) ... )

(define (web-document-template wp)
  (cond
    [(empty? wp) ...]
    [(symbol? (first wp)) ...]
    [else ... (web-page-template (first wp)) ... (web-document-template (rest wp)) ...]))

|#

;; occurs : web-page -> boolean
;; Determines if symbol occurs in wp
(define (occurs symbol wp)
  (search-in-document symbol (wp-body wp)))


;; searh-in-document : web-document -> boolean
;; Determines if symbol occurs in wd
(define (search-in-document symbol wd)
  (cond
    [(empty? wd) false]
    [(symbol? (first wd)) (or (symbol=? symbol (first wd)) (search-in-document symbol (rest wd)))]
    [else (or (occurs symbol (first wd)) (search-in-document symbol (rest wd)))]))

;; TESTS
(define wp1 (make-wp 'empty-page empty))
(define lipsum (list 'Lorem 'Ipsum 'Dolor 'Sit 'Amet))
(define wd (cons wp1 lipsum))
(define wp2 (make-wp 'lorem lipsum))
(define wp3 (make-wp 'empty-lipsum wd))
(define wordlist (cons 'test lipsum))
(define wp4 (make-wp 'words wordlist))

(check-expect (occurs 'hello wp1) false)
(check-expect (occurs 'Loem wp2) false)
(check-expect (occurs 'Lorem wp2) true)
(check-expect (occurs 'Lorem wp3) true)
(check-expect (occurs 'test wp4) true)
