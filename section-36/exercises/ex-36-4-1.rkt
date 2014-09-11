#lang racket
(require lang/htdp-advanced)
(require htdp/draw)

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

;; dimensions of traffic light
(define WIDTH 50)
(define HEIGHT 160)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)

;; the positions of the bulbs 
(define X-BULBS (quotient WIDTH 2))
(define Y-RED (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))

;; draw-bulb : symbol -> boolean
;; Draws the light of given color
(define (draw-bulb bulb)
  (cond
    [(symbol=? bulb 'red) (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)]
    [(symbol=? bulb 'yellow) (draw-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)]
    [(symbol=? bulb 'green) (draw-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)]))

;; clear-bulb : symbol -> boolean
;; Clears the light of the given location
(define (clear-bulb bulb)
  (cond
    [(symbol=? bulb 'red)
     (and (clear-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS)
          (draw-circle (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
    [(symbol=? bulb 'yellow)
     (and (clear-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS)
          (draw-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow))]
    [(symbol=? bulb 'green)
     (and (clear-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS)
          (draw-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]))

;; switch : symbol symbol -> boolean
;; Clears bulb of first given color and draws bulb of second color
(define (switch from to)
  (and (clear-bulb from) (draw-bulb to)))

;; Definition:
(define (next)
  (cond
   [(symbol=? 'green current-color) (set! current-color 'yellow)]
   [(symbol=? 'yellow current-color) (set! current-color 'red)]
   [(symbol=? 'red current-color) (set! current-color 'green)]))

(define (draw-next-color)
  (begin (clear-bulb current-color) (next) (draw-bulb current-color)))

;; init-traffic-light : -> void
(define (init-traffic-light)
  (set! current-color 'red))

;; Tests:
(start WIDTH HEIGHT)
(init-traffic-light)
(draw-next-color)
(draw-next-color)
(draw-next-color)
