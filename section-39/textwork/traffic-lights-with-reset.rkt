;; make-traffic-light : symbol number  ->  (symbol  ->  true)
;; to create a red light with (make-posn x-posn 0) as the upper-left corner
;; effect: draw the traffic light on the canvas
(define (make-traffic-light street x-posn)
  (local (;; Model:
          ;; current-color : TL-color
          ;; to keep track of the current color of the traffic light
          (define current-color 'red)
	  
	  ;; init-traffic-light :  ->  true
	  ;; to (re)set current-color to red and to (re)create the view 
	  (define (init-traffic-light) ...)
	  
          ;; next :  ->  true
          ;; effect: to change current-color from 'green to 'yellow, 
          ;; 'yellow to 'red, and 'red to 'green
          (define (next) ...)
	  
          ;; next-color : TL-color  ->  TL-color
          ;; to compute the successor of current-color based on the traffic laws
          (define (next-color current-color) ...)
	  ;; service-manager : (symbol  ->  true)
	  ;; to apply either next or init-traffic-light
	  (define (service-manager msg)
	    (cond
	      [(symbol=? msg 'next) (next)]
	      [(symbol=? msg 'reset) (init-traffic-light)]
	      [else (error 'traffic-light "message not understood")])))
    (begin
      ;; Initialize and produce service-manager
      (init-traffic-light)
      service-manager)))
