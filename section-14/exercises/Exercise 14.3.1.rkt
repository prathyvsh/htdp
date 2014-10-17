#lang racket
(require lang/htdp-beginner)

;; A Web-page (short: WP) is either
;; 1. empty
;; 2. (cons s wp)
;; where s is a symbol and wp is a Web page; or
;; 3. (cons ewp wp) 
;; where both ewp and wp are Web pages.

#|
;; TEMPLATE
;; size : WP  ->  number
;; to count the number of symbols that occur in a-wp
(define (size a-wp) 
  (cond
    [(empty? a-wp) ...]
    [(symbol? (first a-wp)) ... (first a-wp) ... (size (rest a-wp)) ...]
    [else ... (size (first a-wp)) ... (size (rest a-wp)) ...]))
|#

;; size : WP  ->  number
;; to count the number of symbols that occur in a-wp
(define (size a-wp)
  (cond
    [(empty? a-wp) 0]
    [(symbol? (first a-wp)) (+ 1 (size (rest a-wp)))]
    [else (+ (size (first a-wp)) (size (rest a-wp)))]))

;; TESTS
(= (size empty) 0)
(= (size (list 'One)) 1)
(= (size (list (list 'One))) 1)
