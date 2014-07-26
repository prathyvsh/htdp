#lang racket
(require htdp/draw)
(require lang/htdp-intermediate)

;; rectangle is a structure
;; (make-rectangle position number number symbol)
(define-struct rectangle (corner width height fill))

;; draw-a-rectangle : rectangle -> true
;; Draws a given rectangle
(define (draw-a-rectangle r)
  (process-rectangle draw-solid-rect r))

;; clear-a-rectangle : rectangle -> true
;; Clears a given rectangle
(define (clear-a-rectangle r)
  (process-rectangle clear-solid-rect r))

;; translate-rectangle : rectangle number -> rectangle
;; Moves rectangle to the right by the given delta value
(define (translate-rectangle r delta)
  (local ((define (move-right p x)
            (make-posn (+ x (posn-x p)) (posn-y p)))
          (define (translation corner width height color)
            (make-rectangle (move-right corner delta) width height color)))
  (process-rectangle translation r)))

;; process-rectangle : rect ((rect-corner rect-width rect-height rect-fill) -> Y) -> Y
;; Functions to act on a rectangle
(define (process-rectangle rect fun)
  (fun (rectangle-corner rect)
       (rectangle-width rect)
       (rectangle-height rect)
       (rectangle-fill rect)))

;; TESTS
(start 300 300)
(define pink-r (make-rectangle (make-posn 30 30) 20 40 'pink))

(draw-a-rectangle pink-r)
(clear-a-rectangle pink-r)

(draw-a-rectangle pink-r)
(draw-a-rectangle (translate-rectangle pink-r 50))
