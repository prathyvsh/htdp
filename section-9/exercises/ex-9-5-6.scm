#|
;; TEMPLATE
(define (delta first-list second-list)
  (... first-list ... second-list))

|#

;;delta : list-of-numbers list-of-numbers -> number
;;Calculates difference between the sum of first-list and second-list
(define (delta first-list second-list)
  (- (sum second-list) (sum first-list)))

;; sum : list-of-numbers -> number
;; to compute the sum of the numbers on a-list-of-nums
(define (sum a-list-of-nums)
  (cond
    [(empty? a-list-of-nums) 0]
    [else (+ (first a-list-of-nums) (sum (rest a-list-of-nums)))]))

;; TESTS

(define small-list (cons 3 (cons 4 (cons 5 empty))))
(define big-list (cons 27 (cons 3 (cons 4 (cons 5 empty)))))
(define bigger-list (cons 3 (cons 27 (cons 3 (cons 4 (cons 5 empty))))))

(= (delta small-list big-list) 27)
(= (delta small-list bigger-list) 30)
(= (delta empty big-list) (sum big-list))
