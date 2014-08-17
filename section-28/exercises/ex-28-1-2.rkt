#lang racket
(require lang/htdp-intermediate-lambda)

;; A node is a symbol
;; A graph is
;; (listof (list node (listof nodes)))

;; neighbors : node graph -> (listof nodes)
;; Finds the neighbors of the node
(define (neighbors n g)
  (cond
   [(empty? g) empty]
   [(symbol=? n (first (first g))) (second (first g))]
   [else (neighbors n (rest g))]))


;; TESTS
(define Graph 
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(equal? (neighbors 'A Graph) '(B E))
(equal? (neighbors 'C Graph) '(D))
