#lang racket
(require lang/htdp-beginner)

;;circle ->
(define-struct circle (center radius color))

;; EXAMPLES
(make-circle (make-posn 1 1) 1 'red)
(make-circle (make-posn 10 10) 1 'red)

;; TEMPLATE
;;(define (fun-for-circle a-circle)
;;  ... (circle-center a-circle) ...
;;  ... (circle-radius a-circle) ...
;;  ... (circle-perimeter a-circle) ...)

