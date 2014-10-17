#lang racket
(require lang/htdp-beginner)

;; A Web-page (short: WP) is either
;; 1. empty
;; 2. (cons symbol wp)
;; A list of symbols
;; 3. (cons ewp wp)
;; A list of list of symbols.


;; replace : symbol symbol webpage -> web-page
;; Replaces occurences of old with new on wp.
(define (replace old new a-wp)
  (cond
    [(empty? a-wp) empty]
    [(symbol? (first a-wp))
              (cond
                [(symbol=? (first a-wp) old) (cons new (replace old new (rest a-wp)))]
                [else (cons (first a-wp) (replace old new (rest a-wp)))])]
    [else (cons (replace old new (first a-wp)) (replace old new (rest a-wp)))]))

;; TESTS
(define emptywebpage empty)
(define webpage1 (list 'One))
(define webpage2 (list webpage1))
(define webpage3 (list 'One webpage1))
(define webpage4 (list webpage2 webpage1))

(replace 'One 'Two empty) "should be" empty "****"
(replace 'One 'Two webpage1) "should be" (list 'Two) "****"
(replace 'One 'Two webpage2) "should be" (list (list 'Two)) "****"
(replace 'One 'Two webpage3) "should be" (list 'Two (list 'Two)) "****"
(replace 'One 'Two webpage4) "should be" (list (list (list 'Two)) (list 'Two))

