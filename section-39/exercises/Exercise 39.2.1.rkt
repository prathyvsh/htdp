#lang racket
(require lang/htdp-advanced)
(require htdp/draw)
(require htdp/gui)

;; make-city
(define (make-city)
  (local (
          ;; state variable that stores the traffic lights
          (define traffic-lights empty)
          ;; add-light : symbol number -> void
          ;; Adds a light to the state variable
          (define (add-light name x-posn)
            (local ((define chosen-light (find-light name)))
              (cond
               [(empty? chosen-light)
                (set! traffic-lights (cons (make-traffic-light name x-posn) traffic-lights))]
               [else false])))
          ;; remove-light : symbol -> void
          ;; Removes a light from the traffic light collection
          (define (remove-light name)
            (checked-operations name 'remove-light
                                (lambda (x)
                                  (begin (set! traffic-lights (remove x traffic-lights))
                                         (clear-canvas)
                                         (map (lambda (x) (x 'draw)) traffic-lights)
                                         (void)))))
          ;; switch-light : symbol -> void
          ;; Switches the light with the given name.
          (define (switch-light name)
            (checked-operations name 'switch-light (lambda (x) (x 'next))))

          ;; reset-light : symbol -> void
          ;; Resets the traffic light with the given name.
          (define (reset-light name)
            (checked-operations name 'reset-light (lambda (x) (x 'reset))))

          ;; checked-operations : symbol symbol (symbol -> void)
          ;; Checked operations for the operations.
          (define (checked-operations name op-name operation)
            (local ((define chosen-light (find-light name)))
              (cond
               [(not (empty? chosen-light)) (operation chosen-light)]
               [else false])))
          ;; find-light : symbol -> TL-Service
          ;; Returns a service with the given name otherwise empty
          (define (find-light name)
            (foldl (lambda (tl-service rest) (cond
                                              [(symbol=? name (tl-service 'street)) tl-service]
                                              [else rest])) empty traffic-lights))
          ;; traffic-manager : symbol -> TL-Service
          ;; Traffic manager that processes messages.
          (define (traffic-manager msg)
            (cond
             [(symbol=? 'add msg) (lambda (name x-posn) (add-light name x-posn))]
             [(symbol=? 'remove msg) (lambda (name) (remove-light name))]
             [(symbol=? 'switch msg) (lambda (name) (switch-light name))]
             [(symbol=? 'reset msg) (lambda (name) (reset-light name))])))
    (begin traffic-manager)))


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
             [(symbol=? 'red current-color) 'green]))

          ;; service-manager : (symbol  ->  true)
          ;; to apply either next or init-traffic-light
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'street) street]
             [(symbol=? msg 'next) (next)]
             [(symbol=? msg 'reset) (init-traffic-light)]
             [(symbol=? msg 'location) x-posn]
             [(symbol=? msg 'draw) (draw-light current-color x-posn)]
             [else (error 'traffic-light "message not understood")])))
    (begin
      ;; Initialize and produce service-manager
      (init-traffic-light)
      service-manager)))

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
(define PADDING 5)

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

;; clear-canvas -> true
;; Clears the entire canvas
(define (clear-canvas)
  (draw-solid-rect (make-posn 0 0) CANVAS-WIDTH CANVAS-HEIGHT 'white))

;; CANVAS DIMENSIONS
(define CANVAS-WIDTH 300)
(define CANVAS-HEIGHT HEIGHT)

(start CANVAS-WIDTH CANVAS-HEIGHT)

;; gui-for-city -> void
;; Creates a user interface for city of traffic lights.
(define (gui-for-city)
  (local ((define city (make-city))
          (define street-field (make-text "Street Name:"))
          (define location-field (make-text "Location:"))
          (define status-message (make-message "Welcome to City Lights!"))
          (define (street-input) (string->symbol (text-contents street-field)))
          (define (location-input) (string->number (text-contents location-field)))
          (define (add-event e) (event-handler "Traffic light added" 'add))
          (define (remove-event e) (event-handler "Traffic light removed" 'remove))
          (define (switch-event e) (event-handler "Switching light" 'switch))
          (define (reset-event e) (event-handler "Resetting light" 'reset))
          (define (event-handler indication msg)
            (local ((define (invalid-entry-alert) (begin (draw-message status-message "Please enter a valid input") true))
                    (define (success-alert) (draw-message status-message indication)))
              (cond
               [(symbol=? msg 'add) (handle-error
                                     (if (or (equal? (street-input) "")
                                             (false? (location-input))) (invalid-entry-alert)
                                             (begin (success-alert)
                                                    ((city msg) (street-input) (location-input))))
                                     "You have already added that street")]
               [else (handle-error (if (equal? (street-input) "") (invalid-entry-alert)
                                       (begin (success-alert) ((city msg) (street-input)))) "No such street could be found")])))
          (define (handle-error result error-message) (if (false? result) (draw-message status-message error-message) true))
          (define add-button (make-button "Add" add-event))
          (define remove-button (make-button "Remove" remove-event))
          (define switch-button (make-button "Switch" switch-event))
          (define reset-button (make-button "Reset" reset-event)))
    (create-window (list (list street-field location-field)
                         (list add-button remove-button switch-button reset-button)
                         (list status-message)))))

(gui-for-city)
