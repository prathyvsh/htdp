;; f : number  ->  number
(define (f x)
  (+ (* 3 (* x x)) 
     (+ (* -6 x)
        -1)))

#|
;; TEMPLATE
(define (tabulate-f n)
  (cond
    [(zero? n) ...]
    [... (tabulate-f (sub1 n)) ...]))
 |#

;; tabulate-f : N -> list-of-posns
;; Creates a table by applying f for numbers 1 to n
(define (tabulate-f n)
  (cond
    [(zero? n) empty]
    [else (cons (make-posn n (f n)) (tabulate-f (sub1 n)))]))

;; TESTS
(tabulate-f 0) "should be" empty
(tabulate-f 3) "should be"
(cons (make-posn 3 (f 3)) (cons (make-posn 2 (f 2)) (cons (make-posn 1 (f 1)) empty)))
