;; switch : N  ->  void
;; effect: switch the traffic light n times, holding each color for 3 seconds
;; structural recursion 
(define (switch n)
  (cond
    [(= n 0) (void)]
    [else (begin (sleep-for-a-while 3)
                 (next)
                 (switch (- n 1)))]))

;; switch-forever :  ->  void
;; effect: switch the traffic light forever, holding each color for 3 seconds
;; generative recursion 
(define (switch-forever)
  (begin (sleep-for-a-while 3)
         (next)
         (switch-forever)))
