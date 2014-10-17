#lang racket
(require lang/htdp-beginner)

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

;;(check-expect (occurs 'hello wp1) false)
;(check-expect (occurs 'Loem wp2) false)
;(check-expect (occurs 'Lorem wp2) true)
;(check-expect (occurs 'Lorem wp3) true)
;(check-expect (occurs 'test wp4) true)

;; EXTRA TESTS
;; data examples:
(define empty-page (make-wp 'empty-page empty))
(define page-1-word (make-wp 'page-1-word (cons 'w1 empty)))
(define page-2-words (make-wp 'page-2-words (list 'w1 'w2)))
(define with-1-word-subpage (make-wp 'page-1-word-with-subpage (cons page-1-word empty)))
(define with-2-words-subpage (make-wp 'with-2-words-subpage (cons page-2-words empty)))
(define dense-page1 (make-wp 'realistic (list 'w3  page-2-words 'w4 page-1-word 'w5)))
(define dense-page2 (make-wp 'realistic (list 'w3  empty-page 'w4 with-1-word-subpage 'w5)))

;; test cases

;; test for 'find'
(check-expect (occurs 'w1 empty-page) false)
(check-expect (occurs 'w1 page-1-word) true)
(check-expect (occurs 'w3 page-2-words) false)
(check-expect (occurs 'w2 with-2-words-subpage) true)
(check-expect (occurs 'no-in-there dense-page1) false)
(check-expect (occurs 'w1 dense-page1) true)
(check-expect (occurs 'w2 dense-page1) true)
(check-expect (occurs 'w1 dense-page2) true)
(check-expect (occurs 'w5 dense-page1) true)
