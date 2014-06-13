;;circle ->
(define-struct circle (center radius color))

;; TEMPLATE
;;(define (fun-for-circle a-circle)
;;  ... (circle-center a-circle) ...
;;  ... (circle-radius a-circle) ...
;;  ... (circle-perimeter a-circle) ...)

;; draw-a-circle : circle -> true
;; Draws a give circle on screen
(define (draw-a-circle c)
  (draw-circle (circle-center c) (circle-radius c) (circle-color c)))

;; clear-circle : circle -> true
;; Clears the given circle on screen
(define (clear-a-circle c)
  (clear-circle (circle-center c)
                (circle-radius c)
                (circle-color c)))

;; draw-and-clear-circle : circle number -> true
;; Draws a circle c and clears it after 1 second
(define (draw-and-clear-circle c)
  (and (draw-a-circle c)
       (sleep-for-a-while 1)
       (clear-a-circle c)))

;; move-right : position number -> point
;; Moves point p to the right x pixels
(define (move-right p x)
  (make-posn (+ x (posn-x p)) (posn-y p)))

;; translate-circle circle number -> circle
;; Moves circle to the right by the given delta value
(define (translate-circle circle delta)
  (make-circle (move-right (circle-center circle) delta)
               (circle-radius circle)
               (circle-color circle)))

;; move-circle : number circle -> circle
;; To draw and clear a circle, translate it by delta pixels
(define (move-circle delta a-circle)
  (cond
    [(draw-and-clear-circle a-circle) (translate-circle a-circle delta)]
    [else a-circle]))

;; TESTS
(start 200 100)
(define c (make-circle (make-posn 50 50) 20 'red))
(draw-a-circle (move-circle 10 (move-circle 10 c)))
