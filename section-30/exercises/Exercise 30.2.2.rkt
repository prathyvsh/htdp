#lang racket
(require lang/htdp-intermediate-lambda)

;; route-exists2? : node node simple-graph  ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists2? orig dest sg)
  (local (;; neighbor : node simple-graph  ->  node
          ;; to determine the node that is connected to a-node in sg
          (define (neighbor a-node sg)
            (cond
             [(empty? sg) (error "neighbor: impossible")]
             [else (cond
                    [(symbol=? (first (first sg)) a-node) (second (first sg))]
                    [else (neighbor a-node (rest sg))])]))
          ;; contains : symbol (listof symbol) -> boolean
          ;; Determines if the list contains the given symbol
          (define (contains? a-symbol a-list)
            (ormap (lambda (x) (symbol=? a-symbol x)) a-list))
          (define (re-accu? orig accu-seen)
            (cond
             [(symbol=? orig dest) true]
             [(contains? orig accu-seen) false]
             [else (re-accu? (neighbor orig sg) (cons orig accu-seen))]))) 
    (re-accu? orig empty)))

;; TESTS
(define SimpleG '((A B) (B C) (C E) (D E) (E B) (F F)))  

;; test-on-all-nodes : graph -> (listof (listof symbol symbol boolean))
;; Tests route-exists2? on all nodes of the graph
(define (test-on-all-nodes graph)
  (map (lambda (g1)
         (map (lambda (g2)
                (list (first g1) (first g2) (route-exists2? (first g1) (first g2) graph))) graph)) graph))

(test-on-all-nodes SimpleG)
