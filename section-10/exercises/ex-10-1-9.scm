;; controller : number -> list-of-amount
;; Takes in a number of cents and converts it into a textual description in list
;; format
;; EXAMPLE
;; (controller 103) becomes
;; (cons 1 (cons 'dollar (cons 'and (cons 3 (cons 'cents empty)))))
(define (controller value)
  (cons (dollar-value value) (cons (proper-symbol 'dollar value) (cons 'and (cons (cent-value value) (cons (proper-symbol 'cent value) empty))))))

;; dollar-value : number -> number
;; Converts given cents to dollars
(define (dollar-value value)
  (quotient value 100))
(define (dollar-value-alt value)
  (count-100 value))

;; cent-value : number -> number
;; Converts given cents in to dollars and gives back the remainder
(define (cent-value value)
  (remainder value 100))
(define (cent-value-alt value)
  (- value (* 100 (dollar-value value))))

(define (count-100 value)
  (cond
    [(< value 100) 0]
    [else (+ 1 (count-100 (- value 100)))]))


;; proper-symbol : symbol number -> symbol
;; Pluralizes denomination according to value
(define (proper-symbol denomination value)
  (cond
    [(symbol=? denomination 'dollar)
     (cond
      [(> (dollar-value value) 1) 'dollars]
      [else 'dollar])]
    [(symbol=? denomination 'cent)
     (cond
      [(> (cent-value value) 1) 'cents]
      [else 'cent])]
    [else (error 'proper-symbol "Unknown denomination given")]))

;; checked-controller
(define (checked-controller value)
  (cond
    [(and (<= (quotient value 100) 20) (<= (remainder value 100) 20)) (controller value)]
    [else (error 'checked-controller "Sound only works for cents and dollars less than 20")]))


;; TESTS
(checked-controller 101) "should be"
(cons 1 (cons 'dollar (cons 'and (cons 1 (cons 'cent empty)))))
(checked-controller 1403) "should be"
(cons 14 (cons 'dollars (cons 'and (cons 3 (cons 'cents empty)))))
;;(checked-controller 1430) "should throw error"
(checked-controller 2112) "should throw error"
