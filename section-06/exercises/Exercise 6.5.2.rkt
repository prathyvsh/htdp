#lang racket
(require lang/htdp-beginner)

(define-struct time (h m s))

;; time->seconds time -> number
;; Calculates the number of seconds from midnight since the given time.
(define (time->seconds time)
  (+ (* (time-h time) 3600) (* (time-m time) 60) (time-s time)))

;; TESTS
(= (time->seconds (make-time 12 30 2)) 45002)
