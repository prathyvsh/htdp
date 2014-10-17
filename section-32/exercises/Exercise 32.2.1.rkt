#lang racket
(require lang/htdp-intermediate-lambda)

(define MC 3)
(define BOAT-CAPACITY 2)

;; A distribution is
;; (make-distribution number number)
(define-struct distribution (mis can))

;; A boat is
;; (make-boat symbol distribution)
(define-struct boat (at-dock load))

;; A board is
;; (make-board distribution boat distribution
(define-struct board (beg boat end))

;; draw-board : board -> (listof (listof symbol) (listof (listof symbol)) (listof symbol))
;; Draws the given board on console.
(define (draw-board lay-of-land)
  (list (draw-land (board-beg lay-of-land)) (draw-boat (board-boat lay-of-land)) (draw-land (board-end lay-of-land))))

;; draw-land : distribution -> (listof symbol)
;; Draws a given distribution
(define (draw-land dist)
  (local ((define priest-count (distribution-mis dist))
          (define cannibal-count (distribution-can dist))
          (define (draw-remaining-elements x) (draw-representation (- MC x) '_)))
    (append (draw-representation priest-count '+) (draw-remaining-elements priest-count)
            (draw-representation cannibal-count '^) (draw-remaining-elements cannibal-count))))

;; draw-can : distribution -> (listof symbol)
;; Draws cannibals as ^s
(define (draw-can dist)
  (draw-representation (distribution-can dist) '+))

;; draw-mis : distribution -> (listof symbol)
;; Draws missionaries as +s
(define (draw-mis dist)
  (draw-representation (distribution-mis dist) '+))

;; draw-representation : count symbol -> (listof symbol)
;; Draws a given symbol count times.
(define (draw-representation count symbol)
  (build-list count (lambda (x) symbol)))

;; draw-boat : boat -> (listof (listof symbol))
;; Draws a boat as list of list of symbols.
(define (draw-boat boat)
  (local ((define (draw-boat-load dist)
            (append (draw-mis dist) (draw-can dist))))
    (cond [(boat-at-dock boat) (list (draw-boat-load (boat-load boat)) '~)]
          [else (list '~ (draw-boat-load (boat-load boat)))])))

;; TESTS
;; Initial
(define start (make-board (make-distribution 3 3) (make-boat true (make-distribution 0 0)) (make-distribution 0 0)))

;; Final
(define end (make-board (make-distribution 0 0) (make-boat false (make-distribution 0 0)) (make-distribution 3 3)))

(draw-board start)
(draw-board end)
