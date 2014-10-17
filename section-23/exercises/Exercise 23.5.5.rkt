#lang racket
(require lang/htdp-intermediate)

;; line-from-two-points : posn posn -> (number -> number)
;; Generates line from two points
(define (line-from-two-points-with-pitfall p1 p2)
  (local ((define (y x)
            (/ (- (posn-y p2) (posn-y p1))
               (- (posn-x p2) (posn-x p1))))) y))

;; The equation will fail to yield result when both the points have same x value
;; or in other words when both the points lie on the same vertical line.

;; line-from-two-points : posn posn -> (number -> number)
;; Generates line from two points
(define (line-from-two-points p1 p2)
  (local ((define (y x)
            (cond
             [(= (posn-x p1) (posn-x p2)) (error 'line-from-two-points "Cannot compute slope with points having same x coordinates")]
             [else 
            (/ (- (posn-y p2) (posn-y p1))
               (- (posn-x p2) (posn-x p1)))]))) y))

;; TESTS
(define line (line-from-two-points (make-posn 4 0) (make-posn 5 0)))
(equal? (line 6) 0)

(define line2 (line-from-two-points (make-posn 2 2) (make-posn 4 4)))
(equal? (line2 6) 1)

(define line3 (line-from-two-points (make-posn 2 3) (make-posn 2 4)))
(line3 5) ;throws error
