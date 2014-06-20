;; rectange is a structure
;; (make-rectangle position number number symbol)
(define-struct rectangle (corner width height fill))

;; Template
;; fun-for-rect : rectange -> ???
;(define (fun-for-rect rect)
  ;... (rectangle-corner rect) ...
  ;... (rectangle-width rect) ...
  ;... (rectangle-height rect) ...
  ;... (rectangle-fill rect) ...)

;; draw-a-rectangle : rectangle -> true
;; Draws a given rectangle
(define (draw-a-rectangle r)
  (draw-solid-rect (rectangle-corner r)
                  (rectangle-width r)
                  (rectangle-height r)
                  (rectangle-fill r)))

;; clear-a-rectangle : rectangle -> true
;; Clears a given rectangle from screen
(define (clear-a-rectangle r)
  (clear-solid-rect (rectangle-corner r)
                  (rectangle-width r)
                  (rectangle-height r)
                  (rectangle-fill r)))


;; TESTS
(start 300 300)
(define rect (make-rectangle (make-posn 30 40) 40 50 'blue))
(draw-a-rectangle rect)
(clear-a-rectangle rect)

