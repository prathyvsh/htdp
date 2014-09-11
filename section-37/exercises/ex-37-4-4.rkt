#lang racket
(require lang/htdp-advanced)
(require htdp/draw)

;; Data Def.: A TL-color is either 'green, 'yellow, or 'red.

;; State Variable:

;; first-color : TL-color
;; to keep track of the current color of the traffic light
(define first-color 'red)

;; second-color : TL-color
;; to keep track of the current color of the traffic light
(define second-color 'green)

;; init-traffic-light :  ->  void 
(define (init-traffic-light)
  (begin (set! first-color 'red)
         (set! second-color 'green)
         (draw-solid-rect (make-posn 0 0) 60 180 'black)
         (draw-solid-rect (make-posn 60 0) 180 60 'black)
         (switch-1) (switch-1) (switch-2) (switch-2)))

;; next-1 -> void
;; Switches the color of the first traffic light
(define (next-1)
  (cond
   [(symbol=? 'green first-color) (begin (set! first-color 'yellow)
                                         (set! second-color 'red))]
   [(symbol=? 'yellow first-color) (begin (set! first-color 'red)
                                          (set! second-color 'green))]
   [(symbol=? 'red first-color) (begin (set! first-color 'green)
                                       (set! second-color 'red))]))

;; next-2 -> void
;; Switches the color of the second traffic light
(define (next-2)
  (cond
   [(symbol=? 'green second-color) (begin (set! second-color 'yellow)
                                          (set! first-color 'red))]
   [(symbol=? 'yellow second-color) (begin (set! second-color 'red)
                                           (set! first-color 'green))]
   [(symbol=? 'red second-color) (begin (set! second-color 'green)
                                        (set! first-color 'red))]))

;; dimensions of traffic light
(define WIDTH 300)
(define HEIGHT 300)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)

;; First traffic light parameters
(define X-BULBS-1 30)
(define Y-RED-1 (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW-1 (+ Y-RED-1 BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN-1 (+ Y-YELLOW-1 BULB-DISTANCE (* 2 BULB-RADIUS)))

;; Second traffic light parameters
(define Y-BULBS-2 30)
(define X-RED-2 (+ 60 (+ BULB-DISTANCE BULB-RADIUS)))
(define X-YELLOW-2 (+ X-RED-2 BULB-DISTANCE (* 2 BULB-RADIUS)))
(define X-GREEN-2 (+ X-YELLOW-2 BULB-DISTANCE (* 2 BULB-RADIUS)))

;; draw-light-1 -> void
;; Draws the first traffic light
(define (draw-first-light)
  (cond
   [(symbol=? first-color 'red)
    (draw-solid-disk (make-posn X-BULBS-1 Y-RED-1) BULB-RADIUS first-color)]
   [(symbol=? first-color 'yellow)
    (draw-solid-disk (make-posn X-BULBS-1 Y-YELLOW-1) BULB-RADIUS first-color)]
   [(symbol=? first-color 'green)
    (draw-solid-disk (make-posn X-BULBS-1 Y-GREEN-1) BULB-RADIUS first-color)]))

;; draw-light-2 -> void
;; Draws the first traffic light
(define (draw-second-light)
  (cond
   [(symbol=? second-color 'red)
    (draw-solid-disk (make-posn X-RED-2 Y-BULBS-2) BULB-RADIUS second-color)]
   [(symbol=? second-color 'yellow)
    (draw-solid-disk (make-posn X-YELLOW-2 Y-BULBS-2) BULB-RADIUS second-color)]
   [(symbol=? second-color 'green)
    (draw-solid-disk (make-posn X-GREEN-2 Y-BULBS-2) BULB-RADIUS second-color)]))

;; clear-bulb : symbol -> boolean
;; Clears the light of the given location
(define (clear-first-bulb)
  (cond
   [(symbol=? first-color 'red)
    (and (clear-solid-disk (make-posn X-BULBS-1 Y-RED-1) BULB-RADIUS)
         (draw-circle (make-posn X-BULBS-1 Y-RED-1) BULB-RADIUS 'red))]
   [(symbol=? first-color 'yellow)
    (and (clear-solid-disk (make-posn X-BULBS-1 Y-YELLOW-1) BULB-RADIUS)
         (draw-circle (make-posn X-BULBS-1 Y-YELLOW-1) BULB-RADIUS 'yellow))]
   [(symbol=? first-color 'green)
    (and (clear-solid-disk (make-posn X-BULBS-1 Y-GREEN-1) BULB-RADIUS)
         (draw-circle (make-posn X-BULBS-1 Y-GREEN-1) BULB-RADIUS 'green))]))

(define (clear-second-bulb)
  (cond
   [(symbol=? second-color 'red)
    (and (clear-solid-disk (make-posn X-RED-2 Y-BULBS-2) BULB-RADIUS)
         (draw-circle (make-posn X-RED-2 Y-BULBS-2) BULB-RADIUS 'red))]
   [(symbol=? second-color 'yellow)
    (and (clear-solid-disk (make-posn X-YELLOW-2 Y-BULBS-2) BULB-RADIUS)
         (draw-circle (make-posn X-YELLOW-2 Y-BULBS-2) BULB-RADIUS 'yellow))]
   [(symbol=? second-color 'green)
    (and (clear-solid-disk (make-posn X-GREEN-2 Y-BULBS-2) BULB-RADIUS)
         (draw-circle (make-posn X-GREEN-2 Y-BULBS-2) BULB-RADIUS 'green))]))

;; switch-1 -> void
;; Clears and draws the first bulb
(define (switch-1)
  (begin (clear-bulbs) (next-1) (draw-bulbs)))

;; switch-2 -> void
;; Clears and draws the second bulb
(define (switch-2)
  (begin (clear-bulbs) (next-2) (draw-bulbs)))

;; clear-bulbs -> void
;; Clears the bulbs
(define (clear-bulbs) (begin (clear-first-bulb)
                             (clear-second-bulb)))

;; clear-bulbs -> void
;; draws the bulbs
(define (draw-bulbs) (begin (draw-first-light)
                            (draw-second-light)))
;; switch : N  ->  void
;; effect: switch the traffic light n times, holding each color for 3 seconds
;; structural recursion 
(define (switch n fn)
  (cond
   [(= n 0) (void)]
   [else (begin (sleep-for-a-while 1)
                (fn)
                (switch (- n 1) fn))]))

;; switch-forever :  ->  void
;; effect: switch the traffic light forever, holding each color for 3 seconds
;; generative recursion 
(define (switch-forever)
  (begin (switch 2 switch-1) (switch 2 switch-2) (switch-forever)))


;; TESTS
(begin (set! first-color 'red) (next-1)
       (and (symbol=? first-color 'green)
            (symbol=? second-color 'red)))

;; CANVAS DRAWING
(start WIDTH HEIGHT)
(init-traffic-light)
(switch-forever)
