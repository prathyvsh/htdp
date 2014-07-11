;; replace-eol-with-original : list list -> list
(define (replace-eol-with-original l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) empty]
    [(and (empty? l1) (cons? l2)) l2]
    [(and (cons? l1) (empty? l2)) l1]
    [else (cons (first l1) (replace-eol-with-original (rest l1) l2))]))

;; replace-eol-with-refined : list list -> list
(define (replace-eol-with-refined l1 l2)
  (cond
    [(empty? l1) l2]
    [(empty? l2) l1]
    [else (cons (first l1) (replace-eol-with-refined (rest l1) l2))]))

;; COMMENT: Stepwise iteration yielded a better terminating condition in case l2 is empty.
;; This reduces the number of calls to the recursive function.

;; TESTS
(replace-eol-with-original (list 'a 'b) (list 'c))
(replace-eol-with-refined (list 'a 'b) (list 'c))
(check-expect (replace-eol-with-original (list 'a 'b) empty) (replace-eol-with-refined (list 'a 'b) empty))
