#lang racket
(require lang/htdp-intermediate-lambda)

;; vector+ : vector vector -> vector
;; Adds two vectors together
(define (vector+ v1 v2)
  (build-vector (vector-length v1) (lambda (i) (+ (vector-ref v1 i)
                                                  (vector-ref v2 i)))))

;; vector- : vector vector -> vector
;; Adds two vectors together
(define (vector- v1 v2)
  (build-vector (vector-length v1) (lambda (i) (- (vector-ref v1 i)
                                                  (vector-ref v2 i)))))

;; checked-vector+ : vector vector -> vector
;; Checked version of vector+
(define (checked-vector+ v1 v2)
  (cond
   [(= (vector-length v1) (vector-length v2))
  (build-vector (vector-length v1) (lambda (i) (+ (vector-ref v1 i)
                                                  (vector-ref v2 i))))]
   [else (error 'checked-vector+ "Please provide two vectors with the same length")]))
   
;; checked-vector- : vector vector -> vector
;; Checked version of vector-
(define (checked-vector- v1 v2)
  (cond
   [(= (vector-length v1) (vector-length v2))
  (build-vector (vector-length v1) (lambda (i) (- (vector-ref v1 i)
                                                  (vector-ref v2 i))))]
   [else (error 'checked-vector- "Please provide two vectors with the same length")]))

;; TESTS
(equal? (vector+ (vector 3 4 5) (vector 5 4 6)) (vector 8 8 11))
(equal? (vector- (vector 3 4 5) (vector 5 4 6)) (vector -2 0 -1))
(equal? (checked-vector+ (vector 1) (vector 2 3)))
