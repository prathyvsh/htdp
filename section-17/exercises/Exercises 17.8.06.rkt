#lang racket
(require lang/htdp-beginner-abbr)

#|
A Web-page (short: WP) is either

empty;

(cons s wp) 
where s is a symbol and wp is a Web page; or

(cons ewp wp) 
where both ewp and wp are Web pages.
|#

;; web=? : web-page web-page  ->  boolean
;; to determine whether a-wp and another-wp have the same tree shape
;; and contain the same symbols in the same order
(define (web=? a-wp another-wp)
  (cond
    [(empty? a-wp) (empty? another-wp)]
    [(symbol? (first a-wp))
     (and (and (cons? another-wp) (symbol? (first another-wp)))
          (and (symbol=? (first a-wp) (first another-wp))
               (web=? (rest a-wp) (rest another-wp))))]
    [else 
     (and (and (cons? another-wp) (list? (first another-wp)))
          (and (web=? (first a-wp) (first another-wp))
               (web=? (rest a-wp) (rest another-wp))))]))

;; TESTS
(define emptypage empty)
(define symbolpage (cons 'hello empty))
(define webpage (cons symbolpage empty))
;; empty empty
(web=? empty empty)
;; symbol empty
(not (web=? symbolpage empty))
;; webpage empty
(not (web=? webpage empty))
;; empty symbol
(not (web=? empty symbolpage))
;; symbol symbol
(web=? symbolpage symbolpage)
;; webpage symbol
(not (web=? webpage symbolpage))
;; empty webpage
(not (web=? empty webpage))
;; symbol wepage
(not (web=? symbolpage webpage))
;; webpage webpage
(web=? webpage webpage)
