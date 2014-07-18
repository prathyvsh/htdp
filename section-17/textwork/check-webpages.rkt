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
