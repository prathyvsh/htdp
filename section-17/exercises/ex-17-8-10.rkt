;; replace-eol-with : list-of-numbers list-of-numbers  ->  list-of-numbers
;; to construct a new list by replacing empty in alon1 with alon2
(define (replace-eol-with alon1 alon2)
  (cond
    ((empty? alon1) alon2)
    (else (cons (first alon1) (replace-eol-with (rest alon1) alon2)))))

;; TESTS
(equal? (replace-eol-with (list 1 2 3) (list 4 6)) (list 1 2 3 4 6))
(not (equal? (replace-eol-with (list 1 2) (list 1)) (list 1 2)))

