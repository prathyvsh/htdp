#lang racket
(require lang/htdp-intermediate)

#|
;; DATA DEFINITION
A (pairing X Y) is a structure:
(make-pairing l r) 
where l is an X and r is a Y.
|#
(define-struct pairing (left right))

;;DATA EXAMPLES
;;(listof (pairing number number))
(define number-list (list (make-pairing 3 4)
                          (make-pairing 4 5)
                          (make-pairing 5 6)))

;;(listof (pairing symbol number))
(define sym-num-list (list (make-pairing 'Seven 7) (make-pairing 'Eight 8)))

;;(listof (pairing symbol symbol))
(define sym-list (list (make-pairing 'Seventy 'Nine) (make-pairing 'Twenty 'Hundred)))

;; FUNCTIONS
;; lefts : (listof (pairing X Y)) -> (listof X)
(define (lefts pairings)
  (cond
   [(empty? pairings) empty]
   [else (cons (pairing-left (first pairings)) (lefts (rest pairings)))]))

;; TESTS
(equal? (lefts number-list) (list 3 4 5))
(equal? (lefts sym-num-list) (list 'Seven 'Eight))
(equal? (lefts sym-list) (list 'Seventy 'Twenty))
