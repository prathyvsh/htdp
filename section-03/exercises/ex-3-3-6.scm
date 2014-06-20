;; Celsius->Fahrenheit number -> number
;; Converts celsius to fahrenheit
(define (Celsius->Fahrenheit fahrenheit)
  (+ (* fahrenheit 9/5) 32))

;Fahrenheit to Celsius : number -> number
;Converts fahrenheit given to celsius equivalent
(define (Fahrenheit->Celsius fht)
  (* (/ 5 9) (- fht 32)))


;; TESTS
(Celsius->Fahrenheit 32)

;; I : number  ->  number
;; to convert a Fahrenheit temperature to Celsius and back 
(define (I f)
  (Celsius->Fahrenheit (Fahrenheit->Celsius f)))

(I 32)
;; The composition of the two functions yields an identity function that
;; returns whatever input is given to it. This means that
;; Fahrenheit->Celsius is the exact inverse of Celsius->Fahrenheit.
