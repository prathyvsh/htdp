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
  ...)

;; the-graph : graph
;; the list of all available nodes 
(define the-graph
  (list (create-node 'A)
        (create-node 'B)
        (create-node 'C)
        (create-node 'D)
        (create-node 'E)
        (create-node 'F)))

;; setting up the graph: 
(begin
  (connect-nodes 'A 'B the-graph)
  (connect-nodes 'B 'C the-graph)
  (connect-nodes 'C 'E the-graph)
  (connect-nodes 'D 'E the-graph)
  (connect-nodes 'E 'B the-graph))
