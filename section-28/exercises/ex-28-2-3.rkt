#lang racket
(require lang/htdp-intermediate-lambda)

;; threatened? posn posn -> boolean
;; Determines if the given board-posn is threated by the queen-posn
(define (threatened? queen-posn board-posn)
  (local ((define q-x (posn-x queen-posn))
          (define q-y (posn-y queen-posn))
          (define b-x (posn-x board-posn))
          (define b-y (posn-y board-posn)))
     (or (= q-x b-x)
          (= q-y b-y)
          (= (abs (- q-x b-x)) (abs (- q-y b-y))))))

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

(define (prettify board)
  (build-board (length board) (lambda (i j)
                                (cond
                                 [(board-ref board i j) 'a]
                                 [else '-]))))

;; TESTS

(define BOARD-SIZE 8)

(define (place-queen queen-posn)
  (build-board BOARD-SIZE (lambda (i j) 
    (or (and (= i (posn-x queen-posn)) (= j (posn-y queen-posn)))
        (threatened? queen-posn (make-posn i j))))))

(prettify (place-queen (make-posn 3 2)))

(prettify (place-queen (make-posn 7 7)))

(prettify (place-queen (make-posn 0 0)))
