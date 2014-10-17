#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

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

;; TESTS
(start 300 300)
(define c (make-circle (make-posn 50 50) 20 'red))
(draw-and-clear-circle c 1)
