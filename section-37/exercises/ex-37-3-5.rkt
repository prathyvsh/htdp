#lang racket
(require lang/htdp-advanced)

;; DATA DEFINITION
;; A graph is a list of pair of symbols
;; (listof (symbol symbol))

(define SimpleG 
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F))) 

;; STATE VARIABLES
;; nodes-seen : (listof symbol)
(define nodes-seen empty)

;; graph-init -> void
(define (graph-init)
  (set! nodes-seen empty))
         
;; route-exists? : node node simple-graph  ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists? orig dest sg)
  (begin (set! nodes-seen (cons orig nodes-seen))
  (cond
    [(symbol=? orig dest) true]
    [(contains? orig nodes-seen) false]
    [else (route-exists? (neighbor orig sg) dest sg)])))

;; neighbor : node simple-graph  ->  node
;; to determine the node that is connected to a-node in sg
(define (neighbor a-node sg)
  (cond
    [(empty? sg) (error "neighbor: impossible")]
    [else (cond
	    [(symbol=? (first (first sg)) a-node)
	     (second (first sg))]
	    [else (neighbor a-node (rest sg))])]))

;; contains? : x (listof x) -> boolean
;; Determines if the given element is present in the list
(define (contains? elmt lst)
  (ormap (lambda (x) (equal? x elmt)) lst))

;; TESTS
(graph-init)
(route-exists? 'A 'D SimpleG)
