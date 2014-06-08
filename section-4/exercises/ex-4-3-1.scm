(cond
  [(< n 10) 20]
  [(> n 20) 0]
  [else 1])
;; Legal
                        	
(cond
  [(< n 10) 20]
  [(and (> n 20) (<= n 30))]
  [else 1])
;; Illegal, missing answer value in second condition line

(cond [(< n 10) 20]
      [* 10 n]
      [else 555]) ;  
;; No question value present in second condition line
