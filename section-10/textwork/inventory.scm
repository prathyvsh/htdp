;; DATA DEFINITION

(define (sum an-inv)
  (cond
    [(empty? an-inv) ...]
    [else ... (first an-inv) ... (sum (rest an-inv)) ...]))

;; sum : inventory  ->  number
;; to compute the sum of prices on an-inv
(define (sum an-inv)
  (cond
    [(empty? an-inv) 0]
    [else (+ (ir-price (first an-inv)) (sum (rest an-inv)))]))

