#lang racket 
(require lang/htdp-intermediate-lambda)

;; A peg is a boolean

;; A solitaire board is:
;; (vector (vectorof peg))

;; A move is
;; (make-move posn posn posn)
(define-struct move (from over to))

(define BOARD-SIZE 4)

;; build-board : number -> (vectorof (vectorof number))
;; Builds a board
(define (build-board size f)
  (build-vector size (lambda (n) (build-vector (add1 n) (lambda (m) (f n m))))))

;; board-set! : number number board (number number -> X) -> void
;; Applies given function to the location of the board
(define (board-set! i j b f)
  (vector-set! (vector-ref b i) j (f i j)))

;; TESTS
(define (board-with-hole i j)
  (build-board BOARD-SIZE (lambda (n m)
  (cond
   [(and (= j m) (= i n)) 0]
   [else 1]))))

(define board (board-with-hole 1 1))
