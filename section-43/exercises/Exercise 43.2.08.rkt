#lang racket
(require lang/htdp-advanced)

(define-struct node (name visited to))


;; A simple-graph-node (node) is a structure:
;; (make-node symbol boolean node)

;; create-node : symbol  ->  node
;; to create a simple graph node that contains a-name and itself
(define (create-node a-name)
  (local ((define the-node (make-node a-name false false)))
    (begin (set-node-to! the-node the-node) the-node)))

;; connect-nodes : symbol symbol graph  ->  void
;; effect: to mutate the to field in the structure with
;; from-name in the name field so that it contains
;; the structure with to-name in the name field
(define (connect-nodes from-name to-name a-graph)
  (set-node-to! (lookup-node from-name a-graph)
                (lookup-node to-name a-graph)))

;; lookup-node : symbol graph  ->  node or false
;; to lookup up the node named x in a-graph
(define (lookup-node x a-graph)
  (local ((define result (filter (lambda (i) (equal? (node-name i) x)) a-graph)))
    (cond
      [(empty? result) false]
      [else (first result)])))

;; route-exists? : node node ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists? orig dest sg)
  (local ((define (reset-visited-locations! sg)
             (map (lambda (i) (set-node-visited! i false)) sg))
          (define (route-exists-aux orig dest)
            (cond
             [(or (false? orig) (false? dest)) false]
             [(eq? orig dest) true]
             [(node-visited orig) false]
             [else
              (begin
                (set-node-visited! orig true)
                (route-exists-aux (node-to orig) dest))])))
    (begin (reset-visited-locations! sg)
           (route-exists-aux orig dest))))

;; the-graph : graph
;; the list of all available nodes 
(define A (create-node 'A))
(define B (create-node 'B))
(define C (create-node 'C))
(define D (create-node 'D))
(define E (create-node 'E))
(define F (create-node 'F)) 

(define the-graph (list A B C D E F))

;; setting up the graph: 
(begin
  (connect-nodes 'A 'B the-graph)
  (connect-nodes 'B 'C the-graph)
  (connect-nodes 'C 'E the-graph)
  (connect-nodes 'D 'E the-graph)
  (connect-nodes 'E 'B the-graph))

;; TESTS

(route-exists? A B the-graph)
(route-exists? B C the-graph)
(route-exists? C E the-graph)
(route-exists? D E the-graph)
(route-exists? E B the-graph)
(route-exists? F F the-graph)
(not (route-exists? A F the-graph))
(not (route-exists? A D the-graph))
(not (route-exists? C A the-graph))
(route-exists? A A the-graph)

;; The abstract running time is O(N) if there are N nodes in the graph.
