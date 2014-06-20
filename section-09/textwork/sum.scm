;; TEMPLATE
(define (sum a-list)
  (cond
    [(empty? a-list) ...]
    [else ... (first a-list) ... (sum (rest a-list)) ...]))

;; HEADER
;; sum : list-of-numbers -> number
;; to compute the sum of the numbers on a-list-of-nums
(define (sum a-list-of-nums)
  (cond
    [(empty? a-list-of-nums) 0]
    [else (+ (first a-list-of-nums) (sum (rest a-list-of-nums)))]))


;; TESTS
(= (sum empty) 0)
(= (sum (cons 5 (cons 3 empty)) 8)

