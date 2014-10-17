#lang racket
(require lang/htdp-beginner)
(require htdp/draw)

;; tie-dyed : number -> list-of-numbers
;; Consumes a number and produces a list of random numbers in the range
;; 20 and 120
(define (tie-dyed n)
  (cond
    [(zero? n) empty]
    [else (cons (random-n-m 20 120) (tie-dyed (sub1 n)))]))

;; random-n-m : integer integer -> integer
;; Creates a number between n and m
;; Assume n < m
(define (random-n-m n m)
  (+ (random (- m n)) n))

;; draw-circles : list-of-points number -> true
;; Draws circles with radii as mentioned in list-of-radii with
;; position as center
(define (draw-circles position list-of-radii)
  (cond
    [(empty? list-of-radii) true]
    [else (and (draw-circle position (first list-of-radii))
               (draw-circles position (rest list-of-radii)))]))

;; TESTS
(start 300 300)
(define radii (tie-dyed 8))
(draw-circles (make-posn 150 150) radii)
