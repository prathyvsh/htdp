;; occurs1 : web-page symbol -> number
;; Counts the number of times symbol occurs in wp without considering
;; the nested pages
(define (occurs1 a-wp symbol)
  (cond
    [(empty? a-wp) 0]
    [(symbol? (first a-wp))
     (cond
          [(symbol=? (first a-wp) symbol) (+ 1 (occurs1 (rest a-wp) symbol))]
          [else (occurs1 (rest a-wp) symbol)])]
    [else (occurs1 (rest a-wp) symbol)]))

;; occurs2 : web-page symbol -> number
;; Counts the number of times symbol occurs in wp
(define (occurs2 a-wp symbol)
  (cond
    [(empty? a-wp) 0]
    [(symbol? (first a-wp)) (cond
          [(symbol=? (first a-wp) symbol) (+ 1 (occurs2 (rest a-wp) symbol))]
          [else (occurs2 (rest a-wp) symbol)])]
    [else (+ (occurs2 (first a-wp) symbol) (occurs2 (rest a-wp) symbol))]))

;; TESTS
(define emptywebpage empty)
(define webpage1 (list 'One))
(define webpage2 (list webpage1))
(define webpage3 (list webpage1 'One))
(define webpage4 (list webpage2 webpage1))
(define webpage5 (list webpage1 (list 'Two)))

(= (occurs1 empty 'One) 0)
(= (occurs1 webpage1 'One) 1)
(= (occurs1 webpage2 'One) 0)
(= (occurs1 webpage3 'One) 1)
(= (occurs1 webpage4 'One) 0)
(= (occurs2 webpage4 'One) 2)
(= (occurs2 webpage4 'Two) 0)
(= (occurs2 webpage5 'Two) 1)
