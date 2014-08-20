#lang racket
(require lang/htdp-intermediate-lambda)

;; route-exists2? : node node simple-graph  ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists2? orig dest sg)
  (local ((define (re-accu? orig dest sg accu-seen)
            (cond
             [(= orig dest) true]
             [(contains? orig accu-seen) false]
             [else (re-accu? (neighbor orig sg) dest sg (cons orig accu-seen))]))) 
    (re-accu? orig dest sg empty)))

;; contains : number (listof number) -> boolean
;; Determines if the list contains the given symbol
(define (contains? number a-list)
  (ormap (lambda (x) (= number x)) a-list))

;; neighbor : node simple-graph  ->  node
;; to determine the node that is connected to a-node in sg
(define (neighbor a-node sg)
  (vector-ref sg a-node))

;; TESTS
(define SimpleG (vector '1 2 4 4 1 5))

(equal? (neighbor 0 SimpleG) (list 0 1))

;; test-on-all-nodes : graph -> (listof (listof symbol symbol boolean))
;; Tests route-exists2? on all nodes of the graph
(define (test-on-all-nodes graph)
  (build-vector (vector-length graph) (lambda (i)
         (build-vector (vector-length graph) (lambda (j)
                (list i j (route-exists2? i j graph)))))))

(test-on-all-nodes SimpleG)
