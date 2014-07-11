;; An employee record is
;; (make-emp-rec symbol number number)
(define-struct emp (name number payrate))

;; A punch card is
;; (make-punch-card symbol number)
(define-struct punchcard (ssn hours))

;; A pay record is
;; (make-pay number symbol number)
(define-struct pay (ssn name pay))

;; hours->wages-sorted : list-of-employee-records list-of-punch-cards ->
;; list-of-pay-records
;; Creates a list of pay records from the records and cards sorted in
;; one to one manner.
(define (hours->wages-sorted records cards)
  (cond
    [(and (empty? records) (empty? cards)) empty]
    [(empty? cards) (error 'hours->wages-sorted "Pairs missing from cards")]
    [(empty? records) (error 'hours->wages-sorted "Extra pairs in cards")]
    [else (cond
            [(= (emp-number (first records))
                       (punchcard-ssn (first cards)))
             (cons (make-pay (emp-number (first records)) (emp-name (first records))
                             (weekly-wage (emp-payrate (first records)) (punchcard-hours (first cards))))
                   (hours->wages-sorted (rest records) (rest cards)))]
            [else (error 'hours->wages-sorted "Mismatched Employee Numbers")])]))

;; hours->wages2 : list-of-employee-records list-of-punch-cards ->
;; list-of-pay-records
;; Calculates the wages of each employee in the employee record
;; according to the number of hours worked as listed in the punch cards.
(define (hours->wages2 records cards)
  (hours->wages-sorted (sort records) (sort cards)))

;; sort : list-of-structs
;; Sorts structs in ascending order according to their emp-number or punchcard-ssn
(define (sort lor)
  (cond
    [(empty? lor) empty]
    [else (insert (first lor) (sort (rest lor)))]))

;; get-number : struct
;; Extracts the ssn number out of given emp-number or punchcard
(define (get-number value)
  (cond
    [(emp? value) (emp-number value)]
      [(punchcard? value) (punchcard-ssn value)]
      [else (error 'get-number "Unknown input kind")]))

;; insert : number list-of-number -> list-of-number
;; Insert number in the correct position in ascending order.
(define (insert struct los)
  (cond
    [(empty? los) (cons struct empty)]
    [else (cond
            [(<= (get-number struct) (get-number (first los))) (cons struct los)]
            [else (cons (first los) (insert struct (rest los)))])]))

;; weekly-wage : number number  ->  number
;; to compute the weekly wage from pay-rate and hours-worked
(define (weekly-wage pay-rate hours-worked)
  (* pay-rate hours-worked))

;; TESTS
(define rec1 (list (make-emp 'Bob 232 20) (make-emp 'Don 233 40) (make-emp 'John 89 12)))
(define rec2 (list (make-emp 'Betty 932 35) (make-emp 'Bart 382 45) (make-emp 'Balderoine 235 30)))
(define card1 (list (make-punchcard 232 20) (make-punchcard 233 50) (make-punchcard 89 20)))
(define short-card1 (list (make-punchcard 89 20) (make-punchcard 232 50)))
(define mismatch-card1 (list (make-punchcard 232 20) (make-punchcard 233 20) (make-punchcard 88 50)))
(define card2 (list (make-punchcard 932 30) (make-punchcard 382 10) (make-punchcard 235 10)))
(define long-card2 (list (make-punchcard 932 30) (make-punchcard 382 10) (make-punchcard 235 10) (make-punchcard 20 20)))

;;(hours->wages2 rec1 short-card1)
(hours->wages2 rec1 card1)
(hours->wages2 rec2 card2)
;;(hours->wages-sorted rec1 mismatch-card1)
;;(hours->wages-sorted rec2 long-card2)
