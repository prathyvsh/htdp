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
;; Generates all posible combinations from [start,end] sans it's right diagonal
;; that is, the location where -x = y. This is done since in a triangular peg board
;; a peg can move only towards the hexagonal directions of the adjacent pegs. Never
;; vertically. This when mapped on to a linear vector of vectors means that the peg
;; position on the right diagonals will never be enabled.
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
             [(or (empty? moves) (free? peg-posn board)) empty]
             [(jump-space? (first moves) board) (cons (first moves) (enabled? (rest moves)))]
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

;; final-board? : board -> boolean
;; Determines if the given board is final
(define (final-board? board)
  (= (vector-sum (vector-map count-one board)) 1))

;; count-zero : vector -> number
;; Counts the number of zero in the given vector
(define (count-one v)
  (vector-length (vector-filter (lambda (x) (= x 1)) v)))

;; vector-sum : (vectorof number)  ->  number
;; To compute the sum of the numbers in v
(define (vector-sum v) 
  (vector-sum-aux v (vector-length v)))

;; vector-sum-aux : (vectorof number) N  ->  number
;; To sum the numbers in v with index in [0, i)
(define (vector-sum-aux v i) 
  (cond
   [(zero? i) 0]
   [else (+ (vector-ref v (sub1 i)) 
            (vector-sum-aux v (sub1 i)))]))

;; all-peg-posns : number -> (listof posn)
;; Returns a list of all peg positions in a given board size.
(define (all-peg-posns capacity)
  (local (
          (define (build-table start end)
            (local ((define (generate x y)
                        (cond
                         [(> x end) empty]
                         [(> y x) (generate (add1 x) start)]
                         [else (cons (make-posn x y) (generate x (add1 y)))])))
              (generate start start))))
    (build-table 0 (sub1 capacity))))

;; enabled-pegs : board -> (listof posns)
;; Gives a list of enabled pegs
(define (enabled-pegs board)
  (filter move? (foldr append empty (map (lambda (x) (enabled-peg? x board)) (all-peg-posns (vector-length board))))))

;; solitaire : board -> (listof moves)
;; Produces the list of moves required to solve the board
(define (solitaire board) (local (
(define (solitaire-acc board acc)
  (local ((define moveables (enabled-pegs board)))
    (cond
      [(empty? board) false]
      [(final-board? board) (reverse acc)]
      [else (solitaire-on-each moveables board acc)])))

;; solitaire-on-each : (listof move) board -> boolean
;; Performs solver on each of the possible moves
(define (solitaire-on-each lop board acc)
  (cond
    [(empty? lop) false]
    [else (local ((define next-board-gen (next-board (first lop) board))
                  (define next-step (solitaire-acc next-board-gen (cons (first lop) acc))))
            (cond
    [(false? next-step) (solitaire-on-each (rest lop) board acc)]
    [else next-step]))]))
)
                            (solitaire-acc board empty)))
  ;; TESTS
(define board (build-board BOARD-SIZE (lambda (i j) (cond
                                                       [(and (= i 2) (= j 2)) 0]
                                                       [else 1]))))
(solitaire board)
