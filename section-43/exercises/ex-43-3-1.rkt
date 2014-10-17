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
  (vector-ref (vector-ref a-board j) i))

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
   [else (begin (vector-set! V (sub1 idx) (action (vector-ref V (sub1 idx)) (sub1 idx))) (for-all-aux (sub1 idx)))])))
  (begin (for-all-aux (vector-length V)) V)))

;; TESTS
(define v (vector 1 2 3 4))
(define truthy (lambda (row col) true))
(vec-for-all v (lambda (index value) (add1 value)))
(define board (build-board 8 truthy))
(place-queen board 0 0)
(place-queen board 0 1)
