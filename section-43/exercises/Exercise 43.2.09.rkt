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

;; reset-visited-locations : graph -> void
;; Effect: Resets the visited part of nodes to false
(define (reset-visited-locations! sg) (map (lambda (i) (set-node-visited! i false)) sg))

;; route-exists? : node node ->  boolean
;; to determine whether there is a route from orig to dest in sg
(define (route-exists? orig dest sg)
  (local ((define (route-exists-aux orig dest)
            (cond
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

;; reachable : node -> (void)
;; Effect: Places true into the visited fields of all those nodes
;; that are reachable from the given node and to ensure that the
;; visited fields of all other nodes are false.
(define (reachable node)
  (begin (reset-visited-locations! the-graph) 
         (local ((define (reachable-alt-aux node)
                   (cond
   [(node-visited node) (void)]
   [else (begin (set-node-visited! node true) (reachable-alt-aux (node-to node)))])))
         (reachable-alt-aux node))))

;; TESTS
(define (visit-graph graph) (map node-visited graph))
(reachable E)
(equal? (visit-graph the-graph) (list false true true false true false))
(reachable A)
(equal? (visit-graph the-graph) (list true true true false true false))
(reachable B)
(equal? (visit-graph the-graph) (list false true true false true false))
(reachable C)
(equal? (visit-graph the-graph) (list false true true false true false))
(reachable D)
(equal? (visit-graph the-graph) (list false true true true true false))
(reachable A)
(equal? (visit-graph the-graph) (list true true true false true false))
