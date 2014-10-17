;; hours->wages : list-of-numbers list-of-numbers  ->  list-of-numbers
;; to construct a new list by multiplying the corresponding items on
;; ASSUMPTION: the two lists are of equal length 
;; alon1 and alon2
(define (hours->wages alon1 alon2)
  (cond
    ((empty? alon1) empty)
    (else (cons (weekly-wage (first alon1) (first alon2))
                (hours->wages (rest alon1) (rest alon2))))))

;; weekly-wage : number number  ->  number
;; to compute the weekly wage from pay-rate and hours-worked
(define (weekly-wage pay-rate hours-worked)
  (* pay-rate hours-worked))
