#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

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
  (and (clear-bulb from)
       (draw-bulb to)))

;; TESTS
(start WIDTH HEIGHT)
(clear-bulb 'red)
(clear-bulb 'yellow)
(draw-bulb 'green)
(switch 'green 'yellow)
(switch 'yellow 'red)
