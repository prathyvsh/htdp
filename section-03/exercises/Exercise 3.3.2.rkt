#lang racket
(require lang/htdp-beginner)

;; volume-cylinder : number number -> number
;; Calculates the volume of a cylinder
(define (volume-cylinder radius height)
    (* (area-of-disk radius) height))

(define (area-of-disk radius)
  (* (sqr radius) pi))

;; TESTS
(volume-cylinder 30 10)
