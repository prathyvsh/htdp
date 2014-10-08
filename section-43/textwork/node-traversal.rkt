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
