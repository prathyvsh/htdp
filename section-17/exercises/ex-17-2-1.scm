;; An employee is
;; (make-emp symbol number number)
(define-struct emp (name ssn payrate))

;; A work structure is
;; (make-ws symbol number)
(define-struct ws (name hours))

;; A pay structure is
;; (make-pay symbol number)
(define-struct pay (name weekly-wage))

;; hours-wages : list-of-employee list-of-work-structure -> list-of-work-structure
;; Calculates the payrate of the employee from the given list of work structure
;; ASSUMPTION: emplist and wslist have the same length and
;; contains the employees in the same order.
(define (hours->wages emplist wslist)
  (cond
    [(empty? emplist) empty]
    [else (cons (make-pay (emp-name (first emplist)) (weekly-wage (emp-payrate (first emplist))
                             (ws-hours (first wslist))))
                (hours->wages (rest emplist) (rest wslist)))]))

;; weekly-wage : number number  ->  number
;; to compute the weekly wage from pay-rate and hours-worked
(define (weekly-wage pay-rate hours-worked)
  (* pay-rate hours-worked))

;; TESTS
(define John (make-emp 'John 2323 6))
(define John-WS (make-ws 'John 24))
(define Pete (make-emp 'Pete 2423 8))
(define Pete-WS (make-ws 'Pete 20))

(check-expect (hours->wages empty empty) empty)
(check-expect (hours->wages (list John Pete) (list John-WS Pete-WS)) (list (make-pay 'John (* 6 24)) (make-pay 'Pete (* 8 20))))
