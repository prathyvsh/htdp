#lang racket
(require lang/htdp-beginner)

;; Time is a structure:
;; (make-time number number number)
(define-struct time (h m s))

;; EXAMPLES
(make-time 9 45 0)
(make-time 21 33 59)
