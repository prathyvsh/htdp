;; Data Def.: A TL-color is either 'green, 'yellow, or 'red.

;; State Variable:
;; current-color : TL-color
;; to keep track of the current color of the traffic light
(define current-color 'red)

;; Contract: next : -> void
;; Purpose: the function always produces (void)
;; Effect: to change current-color from 'green to 'yellow, ;; 'yellow to 'red, and 'red to 'green
;; Header: omitted for this particular example

;; Examples:
;; if current-color is 'green and we evaluate (next), then current-color is 'yellow
;; if current-color is 'yellow and we evaluate (next), then current-color is 'red
;; if current-color is 'red and we evaluate (next), then current-color is 'green

;; Template: data-directed on state-variable that is to be mutated
;; (define (f)
;; (cond
;; [(symbol=? 'green current-color) (set! current-color ...)]
;; [(symbol=? 'yellow current-color) (set! current-color ...)]
;; [(symbol=? 'red current-color) (set! current-color ...)]))

;; Definition:
(define (next)
  (cond
   [(symbol=? 'green current-color) (set! current-color 'yellow)]
   [(symbol=? 'yellow current-color) (set! current-color 'red)]
   [(symbol=? 'red current-color) (set! current-color 'green)]))

;; Tests:
(begin (set! current-color 'green) (next) (symbol=? current-color 'yellow))
(begin (set! current-color 'yellow) (next) (symbol=? current-color 'red))
(begin (set! current-color 'red) (next) (symbol=? current-color 'green))
