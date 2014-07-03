;; A Web-page (short: WP) is either
;; 1. empty
;; 2. (cons symbol wp)
;; A list of symbols
;; 3. (cons ewp wp)
;; A list of (list of symbols) or symbols

;; depth : web-page -> number
;; Measure depth of webpage defined as follows:
;; Webpage only with symbols have depth of 0.
;; Page with embedded page has depth of embedded page + 1
;; In case of multiple embedded pages, 
;; max of depth of embedded pages.
(define (depth a-wp)
  (cond
    [(empty? a-wp) 0]
    [(symbol? (first a-wp)) (depth (rest a-wp))]
    [else (+ 1 (max (depth (first a-wp)) (depth (rest a-wp))))]))


;; TESTS
(= (depth '()) 0)
(= (depth '(a b c)) 0)
(= (depth '(a (b c))) 1)
(= (depth '(a (b (c (d))))) 3)
(= (depth '(a (b (c (d))) e (f (g)) h)) 3)
