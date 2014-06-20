;Fahrenheit to Celsius : number -> number
;Converts fahrenheit given to celsius equivalent
(define (Fahrenheit->Celsius fht)
  (* (/ 5 9) (- fht 32)))


;dollar to euro: number -> number
;Converts dollar to euro
;Uses rates on 6 June 2014
;Source: http://oanda.com
(define (dollar->euro dollar)
  (* dollar 0.73450))

;triangular-disk-area: number number -> number
;Takes in length and height of the triangle and outputs it's area.
(define (triangular-disk-area length height)
  (* 1/2 length height))

;Convert3 : number number number -> number
;Builds three digit number from it's digits
;[Note to self] Better generalized recursion implementation possible.
(define (convert3 d1 d2 d3)
  (+ d1 (+ (* d2 10) (* d3 100))))

;Tests
(= (Fahrenheit->Celsius -40) -40)
(= (Fahrenheit->Celsius 32) 0)
(= (Fahrenheit->Celsius 212) 100)

(= (dollar->euro 1) (* 1 0.73450))
(= (dollar->euro 20) (* 20 0.73450))
(= (dollar->euro 50) (* 50 0.73450))

(= (triangular-disk-area 30 10) 150)

(= (convert3 1 2 3) 321)
(= (convert3 3 2 1) 123)
