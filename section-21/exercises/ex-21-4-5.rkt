#lang racket
(require htdp/draw)
(require htdp/arrow)
(require lang/htdp-intermediate)

;; DATA DEFINITION
(define-struct circle (center radius color))
(define-struct rectangle (corner width height color))
(define-struct line (start end color))

;; A shape is either
;; 1. a structure: (make-circle c r color)
;; where c is a posn, r a number and color a symbol.
;; 2. a structure: (make-rectangle corner w h color)
;; where corner is a posn, w and h a number and color a symbol
;; 2. a structure: (make-line start end color)
;; where start and end are posns and color a symbol

;; PICTURE FUNCTIONS
;; *****************


;; move-picture-lr : delta picture -> true or picture
;; Moves a picture horizontally by delta amount
(define (move-picture-lr delta picture) (move-picture translate-picture-lr delta picture))

;; move-picture-ud : delta picture -> true or picture
;; Moves a picture vertically by delta amount
(define (move-picture-ud delta picture) (move-picture translate-picture-ud delta picture))

;; move-picture : (number (listof shape) -> (listof shape)) delta picture -> true or picture
;; Moves a picture as per the mv-fun function by delta amount
(define (move-picture mv-fun delta picture)
  (local (
          ;; draw-and-clear-picture : (listof shape) -> true
          ;; Draws and clears a picture from the screen.
          (define (draw-and-clear-picture pic)
            (and (draw-losh pic) (sleep-for-a-while 1) (clear-losh pic))))
    (cond
     [(draw-and-clear-picture picture) (mv-fun delta picture)]
     [else picture])))

;; draw-losh : list of shape -> true
;; Draws a list of gives shapes
(define (draw-losh a-losh)
  (andmap draw-shape a-losh))

;; clear-losh : (listof shape) -> true
;; Clears a list of gives shapes
(define (clear-losh a-losh)
  (andmap clear-shape a-losh))

;; translate-picture-lr : number (listof shape) -> (listof shape)
;; Translates a list of given shape by delta amount horizontally
(define (translate-picture-lr delta a-losh)
  (translate-losh translate-shape-lr delta a-losh))

;; translate-picture-ud : number (listof shape) -> (listof shape)
;; Translates a list of given shape by delta amount vertically
(define (translate-picture-ud delta a-losh)
  (translate-losh translate-shape-ud delta a-losh))

;; translate-losh : (shape -> shape) (listof shape) number -> true
;; Translates a list of given shape by delta amount
(define (translate-losh fn delta a-losh)
  (local ((define (mv-shape shape) (fn shape delta))) (map mv-shape a-losh)))

;; draw-shape : shape -> true
;; Draws a given shape on the canvas
(define (draw-shape a-shape)
  (process-shape draw-a-rectangle draw-a-circle draw-a-line a-shape))

;; clear-shape : shape -> true
;; Clears a given shape on the canvas
(define (clear-shape a-shape)
  (process-shape clear-a-rectangle clear-a-circle clear-a-line a-shape))

;; translate-shape-lr : shape -> shape
;; Translates a given shape on the canvas left to right
(define (translate-shape-lr a-shape delta)
  (translate-shape translate-rectangle-sideways
                   translate-circle-sideways
                   translate-line-sideways a-shape
                   delta))

;; translate-shape-ud : shape -> shape
;; Translates a given shape on the canvas up or down
(define (translate-shape-ud a-shape delta)
  (translate-shape translate-rectangle-topdown
                   translate-circle-topdown
                   translate-line-topdown a-shape
                   delta))

;; translate-shape : (shape -> shape) (shape -> shape) (shape -> shape) shape -> shape
;; Translates a given shape on the canvas up or down
(define (translate-shape rect-fun circle-fun line-fun a-shape delta)
  (local ((define (mv-rect r) (rect-fun r delta))
          (define (mv-circle c) (circle-fun c delta))
          (define (mv-line l) (line-fun l delta)))
    (process-shape mv-rect mv-circle mv-line a-shape)))

;; process-shape : (rect -> Y) (circle -> Y) (line -> Y) shape -> Y
;; Processes a shape with the given function
(define (process-shape rect-fn circle-fn line-fn a-shape)
  (cond
   [(circle? a-shape) (circle-fn a-shape)]
   [(rectangle? a-shape) (rect-fn a-shape)]
   [(line? a-shape) (line-fn a-shape)]))

;; RECTANGLE FUNCTIONS
;; *******************
;; draw-a-rectangle : rectangle -> true
;; Draws a given rectangle
(define (draw-a-rectangle r)
  (process-rectangle draw-solid-rect r))

;; clear-a-rectangle : rectangle -> true
;; Clears a given rectangle
(define (clear-a-rectangle r)
  (process-rectangle clear-solid-rect r))

;; translate-sideways-rectangle : rectangle number -> rectangle
;; Moves rectangle to the right by the given delta value
(define (translate-rectangle-sideways r delta)
  (translate-rectangle move-sideways r delta))

;; translate-topdown-rectangle : rectangle number -> rectangle
;; Moves rectangle to the right by the given delta value
(define (translate-rectangle-topdown r delta)
  (translate-rectangle move-topdown r delta))

;; translate-rectangle : (rectangle -> rectangle) rectangle number -> rectangle
;; Moves rectangle to the right by the given delta value
(define (translate-rectangle move-fun r delta)
  (local ((define (translation corner width height color)
            (make-rectangle (move-fun corner delta) width height color)))
    (process-rectangle translation r)))

;; process-rectangle : ((rect-corner rect-width rect-height rect-color) -> Y) rect -> Y
;; Applies a function to all parameters of a rectangle
(define (process-rectangle fun rect)
  (fun (rectangle-corner rect)
       (rectangle-width rect)
       (rectangle-height rect)
       (rectangle-color rect)))

;; CIRCLE FUNCTIONS
;; ****************
;; draw-a-circle : circle -> true
;; Draws a given circle on screen
(define (draw-a-circle c)
  (process-circle draw-circle c))

;; clear-a-circle : circle -> true
;; Clears a given circle on screen
(define (clear-a-circle c)
  (process-circle clear-circle c))

;; translate-rectangle-sideways : circle number -> circle
;; Moves circle horizontally by the given delta value
(define (translate-circle-sideways c delta)
  (translate-circle move-sideways c delta))

;; translate-circle-topdown : circle number -> circle
;; Moves circle vertically by the given delta value
(define (translate-circle-topdown c delta)
  (translate-circle move-topdown c delta))

;; translate-circle : (circle -> circle) circle number -> circle
;; Translates the circle according to the given move-fun
(define (translate-circle move-fun c delta)
  (local ((define (translation center radius color)
            (make-circle (move-fun center delta) radius color)))
    (process-circle translation c)))

;; process-circle : ((circle-center circle-radius circle-color) -> Y) circle -> Y
;; Applies a function to all parameters of a circle
(define (process-circle fun c)
  (fun (circle-center c) (circle-radius c) (circle-color c)))

;; LINE FUNCTIONS
;; *******************
;; draw-a-line : line -> true
;; Draws a given line
(define (draw-a-line l)
  (process-line draw-solid-line l))

;; clear-a-line : line -> true
;; Clears a given line
(define (clear-a-line l)
  (process-line clear-solid-line l))

;; translate-line-sideways : line number -> line
;; Moves line horizontally by the given delta value
(define (translate-line-sideways l delta)
  (translate-line move-sideways l delta))

;; translate-line-sideways : line number -> line
;; Moves line vertically by the given delta value
(define (translate-line-topdown l delta)
  (translate-line move-topdown l delta))

;; translate-line : (line -> line) line number -> line
;; Translates line according to the given move-fun
(define (translate-line move-fun l delta)
  (local ((define (translation start end color)
            (make-line (move-fun start delta) (move-fun end delta) color)))
    (process-line translation l)))

;; process-line : ((line-start line-end rect-color) -> Y) line -> Y
;; Applies a function to all parameters of a line
(define (process-line fun l)
  (fun (line-start l)
       (line-end l)
       (line-color l)))

;; COMMON FUNCTIONS
;; ****************
;; move-sideways : posn number -> posn
;; Moves a posn horizontally by x amount.
;; Right side is positive.
(define (move-sideways p x)
  (make-posn (+ x (posn-x p)) (posn-y p)))

;; move-topdown : posn number -> posn
;; Moves a posn vertically by x amount.
;; Downwards is positive.
(define (move-topdown p y)
  (make-posn (posn-x p) (+ (posn-y p) y)))


;; TESTS
(define head-radius 15)
(define canvas-width 250)
(define canvas-height 500)
(define start-x (/ (- canvas-width (* 2 head-radius)) 2))
(define start-y 0)
(define head-x (+ start-x head-radius))
(define head-y (+ start-y head-radius))
(define body-width (* head-radius 2))
(define body-height 20)
(define body-x start-x)
(define body-y (+ head-y head-radius))
(define leg-height 45)
(define leg-slant 25)
(define stand-width 10)
(define exhaust-width 10)
(define exhaust-height 5)

(define l-leg-start-x start-x)
(define l-leg-start-y body-y)
(define l-leg-end-x (- l-leg-start-x leg-slant))
(define l-leg-end-y (+ l-leg-start-y leg-height))

(define r-leg-start-x (+ start-x body-width))
(define r-leg-start-y l-leg-start-y)
(define r-leg-end-x (+ r-leg-start-x leg-slant))
(define r-leg-end-y (+ r-leg-start-y leg-height))

(define head (make-circle (make-posn head-x head-y) head-radius 'black))
(define body (make-rectangle (make-posn body-x body-y) body-width body-height 'black))
(define left-leg (make-line (make-posn l-leg-start-x l-leg-start-y)
                            (make-posn l-leg-end-x l-leg-end-y) 'black))
(define right-leg (make-line (make-posn r-leg-start-x r-leg-start-y)
                             (make-posn r-leg-end-x r-leg-end-y) 'black))

(define l-stand (make-line (make-posn (- l-leg-end-x (/ stand-width 2)) l-leg-end-y)
                           (make-posn (+ l-leg-end-x (/ stand-width 2)) l-leg-end-y) 'black))
(define r-stand (make-line (make-posn (- r-leg-end-x (/ stand-width 2)) r-leg-end-y)
                           (make-posn (+ r-leg-end-x (/ stand-width 2)) r-leg-end-y) 'black))

(define exhaust (make-rectangle (make-posn (+ body-x (/ (- body-width exhaust-width) 2))
                                           (+ body-y body-height))
                                exhaust-width exhaust-height 'black))
(define LUNAR (list head body left-leg right-leg l-stand r-stand exhaust))

(start canvas-width canvas-height)
(draw-losh LUNAR)
(control LUNAR 50 move-picture-lr move-picture-ud draw-losh)
