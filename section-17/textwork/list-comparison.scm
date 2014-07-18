;; list=? : list-of-numbers list-of-numbers  ->  boolean
;; to determine whether a-list and another-list 
;; contain the same numbers in the same order
(define (list=? a-list another-list)
  (cond
    [(and (empty? a-list) (empty? another-list)) true]
    [(or (empty? a-list) (empty? another-list)) false]
    [else (and (= (first a-list) (first another-list))
               (list=? (rest a-list) (rest another-list)))])) ;

(define (list=?-alt a-list another-list)
  (cond
    [(empty? a-list) (empty? another-list)]
    [(cons? a-list)
     (and (cons? another-list)
          (and (= (first a-list) (first another-list))
               (list=?-alt (rest a-list) (rest another-list))))]))
