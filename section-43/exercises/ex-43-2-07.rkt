#lang racket
(require lang/htdp-advanced)

(define-struct node (name to))

;; A simple-graph-node (node) is a structure:
;; (make-node n t) 
;; where n is a symbol and t is a node.

;; create-node : symbol  ->  node
;; to create a simple graph node that contains a-name and itself
(define (create-node a-name)
  (local ((define the-node (make-node a-name false)))
    (begin
      (set-node-to! the-node the-node)
      the-node)))

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

;; contains? : X (listof X) -> boolean
;; Determines if the given element is contained in the list
(define (contains-node? x l) (ormap (lambda (i) (equal? (node-name i) (node-name x))) l))

;; symbolic-graph-to-structures : (listof (listof symbols)) -> graph
;; Consumes a list of pair of nodes (connections) and creates a graph
(define (symbolic-graph-to-structures loc)
  (local ((define the-graph empty)
          (define (connection-aux connections)
  (cond
   [(empty? connections) the-graph]
   [else (local ((define a-connection (first connections))
                 (define from (first a-connection))
                 (define to (second a-connection))

                 ;; add-nodes : (listof node) graph -> true
                 ;; Adds nodes in connection to the graph
                 (define (add-nodes nodes)
                   (cond
                     [(empty? nodes) (void)]
                     [else
                   (local ((define the-node (create-node (first nodes))))
                            (cond
                             [(not (contains-node? the-node the-graph)) (begin (set! the-graph (cons the-node the-graph))
                                                                           (add-nodes (rest nodes)))]
                             [else (begin (add-nodes (rest nodes)))]))])))

                 (begin (add-nodes a-connection)
                        (connect-nodes from to the-graph)
                        (connection-aux (rest connections))))]))) (connection-aux loc)))

;; TESTS
(define the-graph (symbolic-graph-to-structures '((A B) (B C) (C E) (D E) (E B) (F F))))
(define (connection-node name graph)
  (node-name (node-to (lookup-node name graph))))

(equal? (connection-node 'A the-graph) 'B)
(equal? (connection-node 'B the-graph) 'C)
