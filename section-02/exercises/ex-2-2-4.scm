;Convert3 : number number number -> number
;Builds three digit number from it's digits
;[Note to self] Better generalized recursion implementation possible.
(define (convert3 d1 d2 d3)
  (+ d1 (+ (* d2 10) (* d3 100))))

;Tests
(convert3 1 2 3)
(convert3 3 2 1)
