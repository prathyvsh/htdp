;Fahrenheit to Celsius : number -> number
;Converts fahrenheit given to celsius equivalent
(define (Fahrenheit->Celsius fht)
  (* (/ 5 9) (- fht 32)))

;Tests
(Fahrenheit->Celsius -40)
(Fahrenheit->Celsius 32)
(Fahrenheit->Celsius 100)
(Fahrenheit->Celsius 212)
