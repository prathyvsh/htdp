#lang racket
(require lang/htdp-advanced)

;; build-board : N (N N  ->  boolean)  ->  board
;; to create a board of size n x n, 
;; fill each position with indices i and j with (f i j)
(define (build-board n f)
  (build-vector n (lambda (i)
                    (build-vector n (lambda (j)
                                      (f i j))))))

;; board-ref : board N N  ->  boolean
;; to access a position with indices i, j on a-board
(define (board-ref a-board i j)
  (vector-ref (vector-ref a-board i) j))

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

;; place-queen : CB N N  ->  void
;; effect: to set those fields in CB to false that are threatened by 
;; a queen on row i, column j
(define (place-queen CB i j)
  (table-for-all CB (lambda (val row col)
                      (if (threatened? (make-posn i j) (make-posn row col))
                          false val))))

;; unplace-queen : CB N N -> void
;; effect: to set those fields in CB to false that were threatened by 
;; a queen on row i, column j
(define (unplace-queen CB i j)
  (table-for-all CB (lambda (value row col)
                      (cond
                       [(threatened? (make-posn i j) (make-posn row col)) true]
                       [else value]))))

;; table-for-all : (vectorof (vectorfo X)) (X N N -> void)
;; Applies the given action to all elements of the table
(define (table-for-all T action)
  (vec-for-all T (lambda (vec row)
                   (vec-for-all vec (lambda (val col) (action val row col))))))
;; vec-for-all : (vectorof X) (X N -> (void))
;; Applies the given action to all elements of the vector
(define (vec-for-all V action)
  (local
      ((define (for-all-aux idx)
         (cond
          [(zero? idx) (void)]
          [else (begin (vector-set! V (sub1 idx)
                                    (action (vector-ref V (sub1 idx))
                                            (sub1 idx)))
                       (for-all-aux (sub1 idx)))])))
    (begin (for-all-aux (vector-length V)) V)))

;; TESTS
(define truthy (lambda (row col) true))
(define board (build-board 8 truthy))



(equal? (begin (place-queen board 0 1)
               (unplace-queen board 0 1))
        (build-board 8 truthy))
(equal? (begin (place-queen board 2 1)
               (unplace-queen board 2 1))
        (build-board 8 truthy))
(not (equal? (begin (place-queen board 1 1)
                    (unplace-queen board 2 1))
             (build-board 8 truthy)))

;; reset-board : table -> void
;; Resets all the positions of the board
;; to be available or true
(define (reset-board b)
  (table-for-all b (lambda (V i j) true)))

(equal? (begin
          (reset-board board)
          (place-queen board 3 4)
          (place-queen board 4 3)
          (unplace-queen board 3 4)
          (unplace-queen board 4 3))
        (build-board 8 truthy))

;; Placing unplace-queen before place-queen
;; wouldn't be idempotent since place-queen
;; introduces unplace is complementary action
;; of supplementary but not vice-versa.
;; unplace-queen undoes side-effects of
;; place-queen but place-queen doesn't
;; do the same to unplace-queen.
