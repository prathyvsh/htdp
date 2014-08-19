#lang racket
(require lang/htdp-intermediate-lambda)

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

(define (matrix i j)
  (cond
   [(= i 0) (cond [(= j 0) 1] [(= j 1) 0] [(= j 2) -1])]
   [(= i 1) (cond [(= j 0) 2] [(= j 1) 0] [(= j 2) 9])]
   [(= i 2) (cond [(= j 0) 1] [(= j 1) 1] [(= j 2) 1])]))

;; transpose : matrix -> matrix
;; Creates a mirror image of the matrix along its diagonal from the upper-left
;; to the lower-right corner.
(define (transpose mat)
  (build-board (vector-length mat) (lambda (i j) (board-ref mat j i))))


;;TESTS
(define mat (build-board 3 matrix))
(equal? mat (vector (vector 1 0 -1)
                    (vector 2 0 9)
                    (vector 1 1 1)))
(equal? (transpose mat) (vector (vector 1 2 1)
                                (vector 0 0 1)
                                (vector -1 9 1)))
