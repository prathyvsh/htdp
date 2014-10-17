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

;; size : web-page -> number
;; Counts the symbols that appear in the webpage
(define (size wp)
  (size-web-document (body-wp wp)))

;; size-web-document : web-document -> number
;; Counts the symbols that appear in the web-document
(define (size-web-document wd)
  (cond
    [(empty? wd) 0]
    [(symbol? (first wd)) (+ 1 (size (rest wd)))]
    [else (+ (size-web-page (first wd)) (size (rest wd)))]))

;; TESTS
(define webpage1 (make-wp 'hello empty))
