#lang racket 
(require htdp/draw)
(require lang/htdp-intermediate-lambda)

;; A peg is a boolean

;; A solitaire board is:
;;(listof (listof peg))

(define BOARD-SIZE 4)

(define (build-board size f)
  ;;build-pyramid : number number -> (listof (listof number))
  (local ((define (build-pyramid m n)
            (local ((define (build-row n)
                      (cond
                       [(> n m) (vector)]
                       [else (vector-append (vector (f m n)) (build-row (add1 n)))])))
              (cond
               [(>= m size) (vector)]
               [else (vector-append (vector (build-row n)) (build-pyramid (add1 m) n))]))))
    (build-pyramid 0 0)))

;; board-ref : number number board -> peg
(define (board-ref i j b)
  (vector-ref (vector-ref b i) j))

;; occupied? : posn board -> boolean
;; Determines if the peg at the given location is occupied
(define (occupied? peg-posn b)
  (= (board-ref (posn-x peg-posn) (posn-y peg-posn) b) 1))

;; legal-location? : posn -> boolean
;; Determines if the given location is legal in the board
(define (legal-location? peg-posn)
  (and (<= 0 (posn-x peg-posn) (sub1 BOARD-SIZE))
       (<= 0 (posn-y peg-posn) (posn-x peg-posn))))

;; free? : posn board -> boolean
;; Determines if the peg at the given location is free
(define (free? peg-posn b)
  (not (occupied? peg-posn b)) )

;; jump-space? : posn posn board -> boolean
;; Determines if the peg can jump to the given posn2
(define (jump-space? posn1 posn2 b)
  (and (legal-location? posn1) (legal-location? posn2) (occupied? posn1 b) (free? posn2 b)))

;; all-neighbours : posn -> (listof posn)
;; Neighbours of a peg are all the adjacent
;; elements but the right diagonal.
(define (all-jump-pairs peg-posn)
  (gen-locations peg-posn))

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
                         [else (cons (list (make-posn (+ row x) (+ col y))
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
  (local ((define all-locations (all-jump-pairs peg-posn))
          ;; Moves through the adjacents and moves and
          ;; determines if a peg is enabled.
          ;; ASSUMPTION: adj and mov are of the same length.
          (define (enabled? moves)
            (cond
             [(or (empty? moves) (free? peg-posn board)) false]
             [(jump-space? (first (first moves)) (second (first moves)) board) (first moves)]
             [else (enabled? (rest moves))])))
    (enabled? all-locations)))

;; next-board : posn board -> board
;; Produces the next board when given a enabled peg.
(define (next-board peg-posn board)
  (local ((define new-location (enabled-peg? peg-posn board)))
    (build-board BOARD-SIZE (lambda (i j)
                              (cond
                               
                               [(or (and (= i (posn-x (first new-location))) (= j (posn-y (first new-location))))
                                    (and (= i (posn-x peg-posn)) (= j (posn-y peg-posn)))) 0]
                               [(and (= i (posn-x (second new-location))) (= j (posn-y (second new-location)))) 1]
                               [else (board-ref i j board)])))))

;; final-board? : board -> boolean
(define (final-board? board)
  (= (vector-sum (vector-map count-one board)) 1))

;; count-zero : vector -> number
(define (count-one v)
  (vector-length (vector-filter (lambda (x) (= x 1)) v)))

;; vector-sum : (vectorof number)  ->  number
;; to compute the sum of the numbers in v
(define (vector-sum v) 
  (vector-sum-aux v (vector-length v)))

;; vector-sum-aux : (vectorof number) N  ->  number
;; to sum the numbers in v with index in [0, i)
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
  (filter (lambda (x) (cons? (enabled-peg? x board))) (all-peg-posns (vector-length board))))

;; solitaire : board -> boolean
;; ALGORITHM:
;; If there is no enabled peg, or if the board is empty,
;; the algorithm produces false.
;; Create next board from enabled peg.
;; Check if the board is in final state. If it is, produce
;; the moves required for the solution.

;; solitaire : board -> boolean
(define (solitaire board acc)
  (local ((define moveables (enabled-pegs board)))
    (cond
      [(empty? board) false]
      [(final-board? board) (reverse acc)]
      [else (solitaire-on-each moveables board acc)])))

;; solitaire-on-each : (listof peg) board -> boolean
(define (solitaire-on-each lop board acc)
  (cond
    [(empty? lop) false]
    [else (local ((define next-board-gen (next-board (first lop) board))
                  (define next-step (solitaire next-board-gen (cons (first lop) acc))))
            (cond
    [(false? next-step) (solitaire-on-each (rest lop) board acc)]
    [else next-step]))]))

  ;; TESTS
  (define board (build-board BOARD-SIZE (lambda (i j) (cond
                                                       [(and (= i 2) (= j 2)) 0]
                                                       [else 1]))))
(define simple-board (vector (vector 1)
                             (vector 0 1)
                             (vector 0 0 0)))

(solitaire board empty)
