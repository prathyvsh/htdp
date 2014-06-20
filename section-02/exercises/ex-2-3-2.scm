; sum-coins: number number number number -> number
; Computes total amount of money from pennies, nickels, dimes and quarters
(define (sum-coins penny nickel dime quarter)
  (+ penny (* nickel 10) (* dime 20) (* quarter 25)))

;Tests
(sum-coins 0 0 0 0)
(sum-coins 1 3 4 0)
(sum-coins 0 2 2 0)
