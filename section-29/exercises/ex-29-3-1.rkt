#lang racket
(require lang/htdp-intermediate-lambda)

;; A node is a symbol
;; A graph is
;; (vectorof (listof nodes))

;; neighbors : node graph  ->  (listof node)
;; to lookup the node in graph
(define (neighbors node graph)
  (vector-ref graph node))

;; TESTS
(define Graph 
  (vector '(B E) '(E F) '(D) '() '(C F) '(D G) '()))

(equal? (neighbors 0 Graph) '(B E))
(equal? (neighbors 2 Graph) '(D))

