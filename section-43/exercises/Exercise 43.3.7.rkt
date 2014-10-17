#lang racket
(require lang/htdp-advanced)
(require htdp/draw)

;; A peg is a boolean

;; A solitaire board is:
;; (vector (vectorof peg))

;; A move is
;; (make-move posn posn posn)
(define-struct move (from over to))

;; CONSTANTS

;; Number of rows on the triangular peg board
(define BOARD-SIZE 4)

;; FUNCTIONS

;; build-board : number -> (vectorof (vectorof number))
;; Builds a board
(define (build-board size f)
  (build-vector size (lambda (n) (build-vector (add1 n) (lambda (m) (f n m))))))

;; board-ref : posn board -> peg
;; Refers to a location on the board
(define (board-ref pos b)
  (vector-ref (vector-ref b (posn-x pos)) (posn-y pos)))

;; board-set : number number board (number number -> X) -> void
;; Effect : Applies function on the given location of the board
(define (board-set pos b f)
  (vector-set! (vector-ref b (posn-x pos)) (posn-y pos) (f (posn-x pos) (posn-y pos))))

;; free? : posn board -> boolean
;; Determines if the given position on the board is free
(define (free? pos board) (= (board-ref pos board) 1))

;; occupied? : posn board -> boolean
;; Determines if the given position on the board is occupied
(define (occupied? pos board) (not (free? pos board)))

;; jump-space? : posn posn board -> boolean
;; Determines if the peg can jump to the given posn
(define (jump-space? move b) (and (legal-move? move) (occupied? (move-from move) b)
                                  (occupied? (move-over move) b)
                                  (free? (move-to move) b)))

;; reverse-jump-space? : posn posn board -> boolean
;; Determines if the peg can be jumped back to the given position
(define (reverse-jump-space? move b) (and (legal-move? move) (free? (move-from move) b)
                                          (free? (move-over move) b)
                                          (occupied? (move-to move) b)))

;; place-move : move board -> void
;; Effect : Performs the given move on the board
(define (place-move m b)
  (cond
   [(jump-space? m b)
    (begin 
      (blink-peg (move-from m) 'blue)
      (board-set (move-from m) b (lambda (n m) 1))
      (sleep-for-a-while DELAY)
      (draw-hole (move-from m))
      (board-set (move-over m) b (lambda (n m) 1))
      (draw-hole (move-over m))
      (board-set (move-to m) b (lambda (n m) 0))
      (blink-peg (move-to m) 'green)
      (sleep-for-a-while DELAY)
      (draw-peg (move-to m))
      (sleep-for-a-while DELAY))]
   [else false]))

;; unplace-move : move board -> void
;; Effect : Takes back the given move on the board
(define (unplace-move m b)
  (cond
   [(reverse-jump-space? m b)
    (begin 
      (blink-peg (move-to m) 'red)
      (board-set (move-to m) b (lambda (n m) 1))
      (sleep-for-a-while DELAY)
      (draw-hole (move-to m))
      (board-set (move-over m) b (lambda (n m) 0))
      (board-set (move-from m) b (lambda (n m) 0))
      (blink-peg (move-over m) 'blue)
      (blink-peg (move-from m) 'blue)
      (sleep-for-a-while DELAY)
      (draw-peg (move-over m))
      (draw-peg (move-from m))
      (sleep-for-a-while DELAY))]
   [else false]))

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

;; all-moves: number number number posn -> (listof (listof posn posn))
;; Generates all posible combinations from [start,end] sans it's right diagonal
;; that is, the location where -x = y. This is done since in a triangular peg board
;; a peg can move only towards the hexagonal directions of the adjacent pegs. Never
;; vertically. This when mapped on to a linear vector of vectors means that the peg
;; position on the right diagonals will never be enabled.
(define (all-moves peg-posn)
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

;; pretty : board -> void
;; Effect : Prints the board in a pretty format
;; on to the console.
(define (pretty b)
  (begin (vector-map pretty-print b) (void)))

;; final-board? : board -> boolean
;; Determines if the given board is final
(define (final-board? board)
  (= (vector-sum (vector-map count-pegs board)) 1))

;; count-pegs : vector -> number
;; Counts the number of zero in the given vector
(define (count-pegs v)
  (vector-length (vector-filter (lambda (x) (= x 0)) v)))

;; vector-sum : (vectorof number)  ->  number
;; To compute the sum of the numbers in v
(define (vector-sum v) 
  (local (;; vector-sum-aux : (vectorof number) N  ->  number
          ;; To sum the numbers in v with index in [0, i)
          (define (vector-sum-aux v i) 
            (cond
             [(zero? i) 0]
             [else (+ (vector-ref v (sub1 i)) 
                      (vector-sum-aux v (sub1 i)))])))
    (vector-sum-aux v (vector-length v))))


(define (solitaire b)
  (local ((define move-list empty)

          (define (solitaire-aux b)
            (local ((define possible-moves (collect-moves b)))
              (cond
               [(final-board? b) b]
               [else (solver possible-moves b)])))

          ;; remove-element : X (listof X) -> (listof X)
          ;; Removes a given element from a list
          (define (remove-element x lst)
            (foldl (lambda (i j)
                     (cond
                      [(equal? i x) j]
                      [else (cons i j)])) empty lst))

          ;; solver : (listof moves) board -> board or false
          (define (solver moves b)
            (cond
             [(empty? moves) false]
             [else
              (begin (set! move-list (cons (first moves) move-list)) (place-move (first moves) b)
                     (local ((define next-try (solitaire-aux b)))
                       (cond
                        [(false? next-try) (begin (unplace-move (first moves) b)
                                                  (set! move-list (remove-element (first moves) move-list))
                                                  (solver (rest moves) b))]
                        [else next-try])))])))
    (begin (solitaire-aux b) (reverse move-list))))

(define (collect-moves b)
  (local ((define (scan-board i j)
            (cond
             [(>= i (vector-length b)) empty]
             [(>= j (vector-length (vector-ref b i))) (scan-board (add1 i) 0)]
             [else (append (filter (lambda (i) (jump-space? i b)) (all-moves (make-posn i j)))
                           (scan-board i (add1 j)))])))
    (scan-board 0 0)))

;; DRAW CONSTANTS
(define WINDOW-PADDING 50)
(define PEG-SIZE 20)
(define PEG-PADDING 30)
(define CANVAS-SIZE (+ (* BOARD-SIZE 2 PEG-SIZE) (* (sub1 BOARD-SIZE) PEG-PADDING)))
(define WINDOW-SIZE (+ (* 2 WINDOW-PADDING) CANVAS-SIZE))
(define DELAY 0.1)

;; row-of-posns : number number number number -> (listof posn)
;; Creates a row of positions from the given inputs
(define (row-of-posns y displacement offset count)
  (local ((define (displace d) (make-posn (+ offset (* displacement d)) y)))
    (map displace (build-list count (lambda (n) n)))))

;; draw-peg : posn -> true
;; Draws a black peg on screen at the given position
(define (draw-peg pos)
  (local ((define draw-pos (get-draw-posn pos)))
    (draw-solid-disk draw-pos PEG-SIZE 'black)))

;; blink-peg : posn color -> true
;; Blinks a peg in the given color at the given posn
(define (blink-peg pos color)
  (local ((define draw-pos (get-draw-posn pos)))
    (draw-solid-disk draw-pos PEG-SIZE color)))

;; draw-hole : posn -> true
;; Draws a hole on screen at the given position
(define (draw-hole pos)
  (local ((define draw-pos (get-draw-posn pos)))
    (and (clear-solid-disk draw-pos PEG-SIZE)
         (draw-circle draw-pos PEG-SIZE 'black))))

;; get-draw-posn : posn -> posn
;; Translates the vector position in the given board to a location on canvas
(define (get-draw-posn pos)
  (local ((define row (posn-x pos))
          (define col (posn-y pos))
          (define row-size (+ (* row 2 PEG-SIZE) (* row PEG-PADDING)))
          (define col-size (+ (* col 2 PEG-SIZE) (* col PEG-PADDING))))
    (make-posn (+ WINDOW-PADDING (/ (- CANVAS-SIZE row-size) 2) (* (+ (* 2 PEG-SIZE) PEG-PADDING) col))
               (+ WINDOW-PADDING PEG-SIZE (* (+ (* 2 PEG-SIZE) PEG-PADDING) row)))))

(define (lg x) (begin (pretty-print x) x))

;; draw-board -> true
(define (draw-board b)
  (local ((define (draw-aux row col)
            (cond
             [(>= row (vector-length b)) true]
             [(> col row) (draw-aux (add1 row) 0)]
             [else (begin (cond
                           [(occupied? (make-posn row col) b) (draw-peg (make-posn row col))]
                           [else (draw-hole (make-posn row col))])
                          (draw-aux row (add1 col)))])))
    (draw-aux 0 0)))

;; random-board -> board
;; Creates a board with a random hole
(define (random-board)
  (local ((define (board-with-hole i j)
            (build-board BOARD-SIZE (lambda (n m)
                                      (cond
                                       [(and (= j m) (= i n)) 1]
                                       [else 0]))))
          (define random-row (random BOARD-SIZE))
          (define random-col (random (add1 random-row))))
    (board-with-hole random-row random-col)))

;; TESTS
(start WINDOW-SIZE WINDOW-SIZE)
(define board (random-board))
(draw-board board)
(solitaire board)
