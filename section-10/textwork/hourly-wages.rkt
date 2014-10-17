#|
;; TEMPLATE
(define (hours->wages alon)
  (cond
    [(empty? alon) ...]
    [else ... (first alon) ... (hours->wages (rest alon)) ...]))
|#

;; wage : number  ->  number
;; to compute the total wage (at $12 per hour)
;; of someone who worked for h hours
(define (wage h)
  (* 12 h))

;; hours->wages : list-of-numbers -> list-of-numbers
;; to create a list of weekly wages from a list of weekly hours (alon)
(define (hours->wages alon)
  (cond
    [(empty? alon) empty]
    [else (cons (wage (first alon)) (hours->wages (rest alon)))]))

