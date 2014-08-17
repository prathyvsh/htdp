#lang racket
(require lang/htdp-intermediate-lambda)

;; NOTE TO READER
;; The data definition has been modified to illustrate
;; the location of attacked areas and queen positions.
;; 'Q stands for queen position, 'a for attacked area
;; and '- for black space.

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

;; draw-threats : posn board -> board
;; Draws threats on the given board with the given queen-posn
(define (draw-threats queen-posn board)
  (build-board (length board) (lambda (i j) 
                                (local ((define element (board-ref board i j)))
                                (cond
                                 [(and (symbol? element) (symbol=? 'Q element)) 'Q]
                                 [(and (symbol? element) (symbol=? 'a element)) 'a]
                                 [(and (= i (posn-x queen-posn))
                                         (= j (posn-y queen-posn))) 'Q]
                                 [(threatened? queen-posn (make-posn i j)) 'a]
                                 [else '-])))))

;; all-board-locations : number -> (listof (listof posn))
;; Generates a table of all posns
(define (all-board-locations size)
  (build-list size (lambda (x)
                     (build-list size (lambda (y)
                                        (make-posn x y))))))

;; prettify : board -> string
;; Pretty prints given board
(define (prettify board)
  (pretty-print board))

;; placement : N board -> board/false
(define (placement n board)
  (cond
   [(= n 0) board]
   [else (place-queens n (free-spaces board) board)]))

;; place-queens : N (listof posn) board -> board/false
(define (place-queens n free-spaces board)
  (cond
   [(empty? free-spaces) false]
   [else
  (local ((define placement-on-first-space (placement (sub1 n) (draw-threats (first free-spaces) board))))
   (cond
   [(boolean? placement-on-first-space) (place-queens n (rest free-spaces) board)]
   [else placement-on-first-space]))]))

(define (free-spaces board)
  (foldl (lambda (x rest) (append rest x)) empty (map (lambda (x) 
         (filter (lambda (y) (symbol=? (board-ref board (posn-x y) (posn-y y)) '-)) x)) (all-board-locations (length board)))))

;; TESTS

(define (falsy i j) '-)
(define chess (build-board 8 falsy))
(collect-garbage)
(prettify (placement 8 chess))
