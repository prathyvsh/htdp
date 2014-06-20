;; checked-area-of-disk : Scheme-value  ->  number
;; to compute the area of a disk with radius v, 
;; if v is a number
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (> v 0)) (area-of-disk v)]
    [else (error 'checked-area-of-disk "Positive number expected")]))

;; area-of-disk : number  ->  number
;; to compute the area of a disk with radius r
(define (area-of-disk r) 
  (* pi (* r r)))

;; TEST
(checked-area-of-disk 10)
(checked-area-of-disk -2)
(checked-area-of-disk "hello")
