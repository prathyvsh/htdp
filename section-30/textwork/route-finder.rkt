#lang racket
(require lang/htdp-intermediate-lambda)

;; route-exists? : node node simple-graph  ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists? orig dest sg)
  (cond
    [(symbol=? orig dest) true]
    [else (route-exists? (neighbor orig sg) dest sg)]))

;; route-exists2? : node node simple-graph  ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists2? orig dest sg)
  (local ((define (re-accu? orig dest sg accu-seen)
            (cond
              [(symbol=? orig dest) true]
              [(contains? orig accu-seen) false]
              [else (re-accu? (neighbor orig sg) dest sg (cons orig accu-seen))]))) 
    (re-accu? orig dest sg empty)))

;; contains : symbol (listof symbol) -> boolean
;; Determines if the list contains the given symbol
(define (contains? a-symbol a-list)
  (ormap (lambda (x) (symbol=? a-symbol x)) a-list))

;; neighbor : node simple-graph  ->  node
;; to determine the node that is connected to a-node in sg
(define (neighbor a-node sg)
  (cond
    [(empty? sg) (error "neighbor: impossible")]
    [else (cond
	    [(symbol=? (first (first sg)) a-node)
	     (second (first sg))]
	    [else (neighbor a-node (rest sg))])]))

;; TESTS
(define SimpleG 
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F)))  

(route-exists? 'A 'E SimpleG)
(route-exists2? 'A 'E SimpleG)
