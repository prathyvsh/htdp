;; sum : list-of-numbers -> number
;; to compute the sum of the numbers on a-list-of-nums
(define (sum a-list-of-nums)
  (cond
    [(empty? a-list-of-nums) 0]
    [else (+ (first a-list-of-nums) (sum (rest a-list-of-nums)))]))

;; TESTS
(= (sum empty) 0)
(= (sum (cons 1.00 empty)) 1)
(= (sum (cons 17.05 (cons 1.22 (cons 2.59 empty)))) 20.86)
