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

;; find : symbol web-page -> list-of-symbols or boolean
;; Determines if symbol occurs in wp
(define (find symbol wp)
  (build-breadcrumbs (list (wp-header wp)) (search-in-document symbol (wp-body wp))))

(define (build-breadcrumbs v1 v2)
  (cond
    [(boolean? v2) false]
    [else (append v1 v2)]))

(define (backtrack v1 v2)
  (cond
    [(boolean? v1) v2]
    [else v1]))

;; search-in-document : symbol web-document -> list-of-symbols or boolean
(define (search-in-document symbol wd)
  (cond
    [(empty? wd) false]
    [(symbol? (first wd)) (cond
                            [(symbol=? symbol (first wd)) empty]
                            [else (search-in-document symbol (rest wd))])]
    [else (backtrack (find symbol (first wd)) (search-in-document symbol (rest wd)))]))
    

;; TESTS
(define wp0 (make-wp 'empty empty))
(define wp1 (make-wp 'planets (list 'earth 'mars 'uranus)))
(define wp2 (make-wp 'planets2 (list 'neptune 'jupiter 'mercury)))
(define overlap (make-wp 'overlap (list 'earth 'jupiter 'uranus 'mercury)))
(define wp3 (make-wp 'solar-system (list 'sun wp1 wp2)))
(define wp4 (make-wp 'overlap-group (list wp1 wp2 overlap)))
(define wp5 (make-wp 'dark-side (list 'black-death 'spike-reach 'collapsicon)))
(define wp6 (make-wp 'milky-way (list 'astro-belt wp3)))
(define wp7 (make-wp 'tarry-way (list wp5)))
(define wp8 (make-wp 'cluster (list wp6 'uncharted wp7)))
(define wp9 (make-wp 'everything (list wp8)))

(check-expect (find 'something wp0) false)
(check-expect (find 'earth wp1) (list 'planets))
(check-expect (find 'jupiter wp2) (list 'planets2))
(check-expect (find 'sun wp3) (list 'solar-system))
(check-expect (find 'earth wp3) (list 'solar-system 'planets))
(check-expect (find 'neptune wp3) (list 'solar-system 'planets2))
(check-expect (find 'uranus wp4) (list 'overlap-group 'planets))
(check-expect (find 'astro-belt wp6) (list 'milky-way))
(check-expect (find 'collapsicon wp7) (list 'tarry-way 'dark-side))
(check-expect (find 'collapsicon wp8) (list 'cluster 'tarry-way 'dark-side))
(check-expect (find 'jupiter wp9) (list 'everything 'cluster 'milky-way 'solar-system 'planets2))

;; ADDITIONAL TESTS
(define empty-page (make-wp 'empty-page empty))
(define page-1-word (make-wp 'page-1-word (cons 'w1 empty)))
(define page-2-words (make-wp 'page-2-words (list 'w1 'w2)))
(define with-1-word-subpage (make-wp 'page-1-word-with-subpage (cons page-1-word empty)))
(define with-2-words-subpage (make-wp 'with-2-words-subpage (cons page-2-words empty)))
(define dense-page1 (make-wp 'realistic (list 'w3  page-2-words 'w4 page-1-word 'w5)))
(define dense-page2 (make-wp 'realistic (list 'w3  empty-page 'w4 with-1-word-subpage 'w5)))

(check-expect (find 'w1 empty-page) false)
(check-expect (find 'w1 page-1-word) (list 'page-1-word))
(check-expect (find 'w3 page-2-words) false)
(check-expect (find 'w2 with-2-words-subpage) (list 'with-2-words-subpage 'page-2-words))
(check-expect (find 'no-in-there dense-page1) false)
(check-expect (find 'w1 dense-page1) (list 'realistic 'page-2-words))
(check-expect (find 'w2 dense-page1) (list 'realistic 'page-2-words))
(check-expect (find 'w1 dense-page2) (list 'realistic 'page-1-word-with-subpage 'page-1-word))
(check-expect (find 'w5 dense-page1) (list 'realistic))
