;; add-up-3 : list-of-3-numbers  ->  number
;; to add up the three numbers in a-list-of-3-numbers
(define (add-up-3 a-list-of-3-numbers) 
  (+ (first a-list-of-3-numbers) (first (rest a-list-of-3-numbers)) (first (rest (rest a-list-of-3-numbers)))))

;; distance-to-0-for-3 list-of-3-numbers -> number
;; Finds the distance from 0 to a given point represented as a list of
;; 3 numbers.
(define (distance-to-0-for-3 point-3)
  (sqrt (+ (sqr (first point-3)) (sqr (first (rest point-3))) (sqr (first (rest (rest point-3)))))))

;; TESTS
(= (distance-to-0-for-3 (cons 3 (cons 20 (cons 5 empty)))) (sqrt 434))
(= (distance-to-0-for-3 (cons 1 (cons 2 (cons 3 empty)))) (sqrt 14))
