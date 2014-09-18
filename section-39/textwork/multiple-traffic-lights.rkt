;; View:
;; draw-light : TL-color number  ->  true
;; to (re)draw the traffic light on the canvas 
(define (draw-light current-color x-posn) ...))

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
