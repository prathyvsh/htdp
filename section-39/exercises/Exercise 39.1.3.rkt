#lang racket
(require lang/htdp-advanced)
(require htdp/draw)

;; dimensions of traffic light
(define WIDTH 50)
(define BULB-RADIUS 20)
(define DISTANCE-BETWEEN-BULBS 10)
;; the minimum canvas height
(define HEIGHT 
  (+ DISTANCE-BETWEEN-BULBS
     (* 2 BULB-RADIUS)
     DISTANCE-BETWEEN-BULBS
     (* 2 BULB-RADIUS)
     DISTANCE-BETWEEN-BULBS
     (* 2 BULB-RADIUS)
     DISTANCE-BETWEEN-BULBS))

;; Model:
;; make-traffic-light : symbol number  ->  ( ->  true)
;; to create a red light with (make-posn x-posn 0) as the upper-left corner
;; effect: draw the traffic light on the canvas
(define (make-traffic-light street x-posn)
  (local (;; current-color : TL-color
          ;; to keep track of the current color of the traffic light
          (define current-color 'red)
	  
	  ;; init-traffic-light :  ->  true
	  ;; to (re)set current-color to red and to (re)create the view 
	  (define (init-traffic-light)
	    (begin
	      (set! current-color 'red)
	      (draw-light current-color x-posn)))
	  
          ;; next :  ->  true
          ;; effect: to change current-color from 'green to 'yellow, 
          ;; 'yellow to 'red, and 'red to 'green
          (define (next)
            (begin
              (set! current-color (next-color current-color))
              (draw-light current-color x-posn)))
	  
          ;; next-color : TL-color  ->  TL-color
          ;; to compute the successor of current-color based on the traffic laws
          (define (next-color current-color)
            (cond
              [(symbol=? 'green current-color) 'yellow]
              [(symbol=? 'yellow current-color) 'red]
              [(symbol=? 'red current-color) 'green])))
    (begin
      ;; Initialize and produce next
      (init-traffic-light)
      next)))

;; View:
;; draw-light : TL-color number  ->  true
;; to (re)draw the traffic light on the canvas 
(define (draw-light color x-posn)
  (local (;; First traffic light parameters
          (define y-red (+ DISTANCE-BETWEEN-BULBS BULB-RADIUS))
          (define y-yellow (+ y-red DISTANCE-BETWEEN-BULBS (* 2 BULB-RADIUS)))
          (define y-green (+ y-yellow DISTANCE-BETWEEN-BULBS (* 2 BULB-RADIUS)))
          ;; Clears the light of the given location
          (define (clear-all)
            (andmap (lambda (x) (and (clear-solid-disk (make-posn x-posn (first x)) BULB-RADIUS)
                            (draw-circle (make-posn x-posn (first x)) BULB-RADIUS (second x))))
                    (list (list y-red 'red)
                          (list y-yellow 'yellow)
                          (list y-green 'green))))
          (define PADDING 5)
          (define left-x (- x-posn BULB-RADIUS PADDING))
          (define right-x (+ x-posn BULB-RADIUS PADDING)))
    (and (draw-solid-line (make-posn left-x 0) (make-posn left-x HEIGHT))
         (draw-solid-line (make-posn right-x 0) (make-posn right-x HEIGHT))
     (clear-all) (cond
                      [(symbol=? color 'red)
                       (draw-solid-disk (make-posn x-posn y-red) BULB-RADIUS color)]
                      [(symbol=? color 'yellow)
                       (draw-solid-disk (make-posn x-posn y-yellow) BULB-RADIUS color)]
                      [(symbol=? color 'green)
                       (draw-solid-disk (make-posn x-posn y-green) BULB-RADIUS color)]))))

;; CANVAS DRAWING
(start 300 HEIGHT)
(make-traffic-light 'red 150)
