(> 4 3) ;; true
(> 2 3) ;; false
(> 7/2 3) ;; true

(and (> 4 4) (> 4 3)) ;; false
(and (> 4 2) (> 2 3)) ;; false
(and (> 4 7/2) (> 7/2 3)) ;; true

(= (* x x) x)
(= (* 4 4) 4) ;; false
(= (* 2 2) 2) ;; false
(= (* 7/2 7/2) 7/2) ;; false
