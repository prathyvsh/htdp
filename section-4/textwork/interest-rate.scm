;; interest-rate : number -> number
;; To determine the interest rate for the given amount
(define (interest-rate amount) 
  (cond
    [(<= amount 1000) 0.04]
    [(<= amount 5000) 0.045]
    [(> amount 5000) 0.05]
  ))

(= (interest-rate 1000) 0.040)
(= (interest-rate 5000) 0.045)
(= (interest-rate 8000) 0.050)
