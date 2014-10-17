#lang racket
(require lang/htdp-intermediate-lambda)

;; build-board : N (N N  ->  boolean)  ->  board
;; to create a board of size n x n, 
;; fill each position with indices i and j with (f i j)
(define (build-board n f)
  (build-list n (lambda (i)
                  (build-list n (lambda (j)
                                  (f i j))))))

;; board-ref : board N N  ->  boolean
;; to access a position with indices i, j on a-board
(define (board-ref a-board i j)
  (list-ref (list-ref a-board i) j))

;; TESTS

(define (board-ref-checker board size fn)
  (local ((define row (random size))
          (define col (random size)))
  (equal? (board-ref board row col) (fn row col))))

(define (g x y) (+ x y))

(define 8-board (build-board 8 g))

(define (bool x y) (= x y))

(define bool-board (build-board 8 bool))

(board-ref-checker 8-board 8 g)
(board-ref-checker 8-board 8 g)
(board-ref-checker 8-board 8 g)
(board-ref-checker 8-board 8 g)
(board-ref-checker 8-board 8 g)
(board-ref-checker 8-board 8 g)
(board-ref-checker 8-board 8 g)
(board-ref-checker 8-board 8 g)

(board-ref-checker bool-board 8 bool)
(board-ref-checker bool-board 8 bool)
(board-ref-checker bool-board 8 bool)
(board-ref-checker bool-board 8 bool)
(board-ref-checker bool-board 8 bool)
(board-ref-checker bool-board 8 bool)
(board-ref-checker bool-board 8 bool)
(board-ref-checker bool-board 8 bool)
