#lang racket 
(require htdp/draw)
(require lang/htdp-intermediate-lambda)

;; A peg is a boolean

;; A solitaire board is:
;; (vectorof (vectorof peg))

;; A move is
;; (make-move posn posn posn)
(define-struct move (from over to))

(define BOARD-SIZE 5)

;; build-board : number (number -> X) -> (vectorof (vectorof X))
;; Creates a board with the given function
(define (build-board size f)
  ;;build-pyramid : number number -> (vectorof (listof X))
  (local ((define (build-pyramid m n)
            (local ((define (build-row n)
                      (cond
                        [(> n m) (vector)]
                        [else (vector-append (vector (f m n)) (build-row (add1 n)))])))
            (cond
             [(>= m size) (vector)]
             [else (vector-append (vector (build-row n)) (build-pyramid (add1 m) n))]))))
    (build-pyramid 0 0)))

;; board-ref : posn board -> peg
;; References a given position on the board
(define (board-ref m b)
  (vector-ref (vector-ref b (posn-x m)) (posn-y m)))

;; occupied? : posn board -> boolean
;; Determines if the peg at the given location is occupied
(define (occupied? peg-posn b)
  (= (board-ref peg-posn b) 1))

;; free? : posn board -> boolean
;; Determines if the peg at the given location is free
(define (free? peg-posn b)
  (not (occupied? peg-posn b)))

;; legal-location? : posn -> boolean
;; Determines if the given location is legal in the board
(define (legal-location? peg-posn)
  (and (<= 0 (posn-x peg-posn) (sub1 BOARD-SIZE))
       (<= 0 (posn-y peg-posn) (posn-x peg-posn))))

;; legal-move? : move -> boolean
;; Checks if the given move is legal.
(define (legal-move? move)
  (and (legal-location? (move-from move))
       (legal-location? (move-to move))))

;; jump-space? : posn posn board -> boolean
;; Determines if the peg can jump to the given posn2
(define (jump-space? move b) (and (legal-move? move) (occupied? (move-from move) b)
                                  (occupied? (move-over move) b)
                                  (free? (move-to move) b)))

;; all-neighbours : posn -> (listof move)
;; Gives back all moves possible from the given location
(define (all-moves peg-posn) (gen-locations peg-posn))

;; gen-locations: number number number posn -> (listof (listof posn posn))
;; Generates a table from [start,end] sans it's right diagonal
;; that is, the location where -x = y.
(define (gen-locations peg-posn)
  (local ((define row (posn-x peg-posn))
          (define col (posn-y peg-posn))
          (define (build-table start end)
            (local ((define (generate x y)
                      (local ((define pos (make-posn x y)))
                        (cond
                         [(> x end) empty]
                         [(> y end) (generate (add1 x) start)]
                         [(= (- x) y) (generate x (add1 y))]
                         [else (cons (make-move peg-posn (make-posn (+ row x) (+ col y))
                                           (make-posn (+ row (* 2 x)) (+ col (* 2 y))))
                                     (generate x (add1 y)))]))))
              (generate start start))))
    (build-table -1 1)))

;; contains? : X (listof X) -> boolean
;; Determines if x is present in l
(define (contains? x l) (ormap (lambda (y) (equal? x y)) l))

;; enabled-peg? : board posn -> posn/boolean
;; Determines if the given peg is enabled
(define (enabled-peg? peg-posn board)
  (local ((define all-locations (all-moves peg-posn))
          ;; Moves through the adjacents and moves and
          ;; determines if a peg is enabled.
          ;; ASSUMPTION: adj and mov are of the same length.
          (define (enabled? moves)
            (cond
             [(or (empty? moves) (free? peg-posn board)) false]
             [(jump-space? (first moves) board) (first moves)]
             [else (enabled? (rest moves))])))
    (enabled? all-locations)))

;; next-board : move board -> board
;; Produces the next board when given a enabled peg.
(define (next-board new-move board)
    (build-board BOARD-SIZE (lambda (i j)
                   (cond
                     [(or (equal? (make-posn i j) (move-from new-move))
                          (equal? (make-posn i j) (move-over new-move))) 0]
                     [(equal? (make-posn i j) (move-to new-move)) 1]
                     [else (board-ref (make-posn i j) board)]))))

;; TESTS
(define board (build-board BOARD-SIZE (lambda (i j) (cond
                                                      [(and (= i 2) (= j 2)) 0]
                                                      [else 1]))))

(define a-move (make-move (make-posn 0 0) (make-posn 1 0) (make-posn 2 2)))
(define another-move (make-move (make-posn 2 0) (make-posn 2 1) (make-posn 2 2)))
(legal-move? a-move)
(legal-move? another-move)

(equal? (enabled-peg? (make-posn 0 0) board) (make-move (make-posn 0 0) (make-posn 1 1) (make-posn 2 2)))
 
(next-board a-move board)
(next-board another-move board)
