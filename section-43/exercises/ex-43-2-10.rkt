#lang racket
(require lang/htdp-advanced)

(define-struct node (name visited to))
(define-struct seq (node next))

;; A simple-graph-node (node) is a structure:
;; (make-node symbol boolean node)

;; make-simple-graph : (listof (listof symbol symbol)) -> service-manager
;; Creates a simple graph with a service manager
(define (make-simple-graph connections)
  (local
      ;; STATE VARIABLE
      ;; graph : (make-seq symbol graph)
      ((define graph (make-seq false false))
       ;; create-node : symbol  ->  node
       ;; to create a simple graph node that contains a-name and itself
       (define (create-node a-name)
         (local ((define the-node (make-node a-name false false)))
           (begin (set-node-to! the-node the-node) the-node)))

       ;; contains-node? : node -> boolean
       ;; Determines if the given node is present in the graph
       (define (contains-node? n)
         (local
             ((define (contains-aux g)
                (cond
                 [(false? g) false]
                 [else (or (equal? (node-name (seq-node g)) (node-name n))
                           (contains-aux (seq-next g)))])))
           (contains-aux graph)))

       ;; add-node : node graph -> true or void
       ;; Adds a new node to the graph
       (define (add-new-node name)
         (local ((define the-node (create-node name)))
           (cond
            [(false? (seq-node graph)) (set-seq-node! graph the-node)]
            [(not (contains-node? the-node))
             (add-to-tail! (make-seq the-node false))]
            [else (void)])))

       ;; add-to-tail! : sequence -> void
       ;; Effect : Adds the given node to the tail of the graph
       (define (add-to-tail! node)
         (local ((define (add-aux g)
                   (cond
                    [(false? (seq-next g)) (set-seq-next! g node)]
                    [else (add-aux (seq-next g))])))
           (add-aux graph)))

       ;; register-connections : (listof (listof symbol symbol)) -> void
       ;; Effect: Initializes the state variable graph
       (define (register-connections loc)
         (cond
          [(empty? loc) (void)]
          [else (local ((define a-connection (first loc))
                        (define from (first a-connection))
                        (define to (second a-connection)))
                  (begin (map add-new-node a-connection)
                         (connect-nodes from to)
                         (register-connections (rest loc))))]))

       ;; connect-nodes : symbol symbol ->  void
       ;; effect: to mutate the to field in the structure with
       ;; from-name in the name field so that it contains
       ;; the structure with to-name in the name field
       (define (connect-nodes from-name to-name)
         (set-node-to! (lookup-node from-name)
                       (lookup-node to-name)))

       ;; lookup-node : symbol graph ->  node or false
       ;; to lookup up the node named x in the graph
       (define (lookup-node x)
         (local ((define (lookup-aux g)
                   (cond
                    [(false? g) false]
                    [(equal? x (node-name (seq-node g))) (seq-node g)]
                    [else (lookup-aux (seq-next g))])))
           (lookup-aux graph)))

       ;; change-connection : node node -> void
       ;; Changes the connection of the from node.
       (define (change-connection from to) (connect-nodes from to))

       ;; reset-visited-locations! : void
       ;; Effect : Resets the visited field of all nodes in the graph
       (define (reset-visited-locations!)
         (local ((define (reset-aux g)
                   (cond
                    [(false? g) (void)]
                    [else (begin (set-node-visited! (seq-node g) false)
                                 (reset-aux (seq-next g)))])))
           (reset-aux graph)))

       ;; route-exists? : node node ->  boolean
       ;; to determine whether there is a route from orig to dest in sg
       (define (route-exists? start end)
         (local ((define orig (lookup-node start))
                 (define dest (lookup-node end))
                 (define (route-exists-aux o d)
                   (cond
                    [(or (false? o) (false? d)) false]
                    [(eq? o d) true]
                    [(node-visited o) false]
                    [else
                     (begin
                       (set-node-visited! o true)
                       (route-exists-aux (node-to o) d))])))
           (begin (reset-visited-locations!)
                  (route-exists-aux orig dest))))

       ;; visit-all : node -> void
       ;; Effect: Sets the visited field of all connected nodes to true
       (define (visit-all a-node)
         (local ((define (visit-all-aux n)
                   (begin
                     (cond
                      [(node-visited n) (void)]
                      [else (begin (set-node-visited! n true) (visit-all-aux (node-to n)))]))))
           (begin (reset-visited-locations!) (visit-all-aux a-node))))

       ;; unvisited? : node -> boolean
       ;; Determines if the given node is not visited
       (define (unvisited? n) (not (node-visited n)))

       ;; remove-unvisited-nodes! -> void
       ;; Effect: Removes the univisited nodes in the graph
       (define (remove-unvisited-nodes!)
         (local
             ((define (remove-aux last-node g)
                (cond
                 [(false? g) (void)]
                 [(false? (seq-next g)) (cond
                                         [(unvisited? (seq-node g)) (set-seq-next! last-node false)]
                                         [else (void)])]
                 [(unvisited? (seq-node g)) (begin (set-seq-next! last-node (seq-next g)) (remove-aux last-node (seq-next last-node)))]
                 [else (remove-aux g (seq-next g))])))
           (cond
            [(unvisited? (seq-node graph)) (begin (set! graph (seq-next graph)) (remove-unvisited-nodes!))]
            [else (remove-aux graph (seq-next graph))])))

       ;; isolate : node -> void
       ;; Removes all the nodes from the collection that are not traversable
       ;; from the current node
       (define (isolate n) (begin (visit-all (lookup-node n)) 
                                  (remove-unvisited-nodes!)))

       (define (status)
         (local ((define (status-aux g)
                   (cond
                    [(false? g) empty]
                    [else (cons (list (node-name (seq-node g)) (rest (collect-connections (seq-node g))))
                                (status-aux (seq-next g)))]))
                 (define (collect-connections n)
         (local ((define (collect-aux n)
         (cond
          [(or (false? n) (node-visited n)) empty]
          [else (begin (set-node-visited! n true) (cons (node-name n) (collect-aux (node-to n))))])))
           (begin (reset-visited-locations!) (collect-aux n)))))
           (status-aux graph)))

       

       (define (service-manager msg)
         (cond
          [(symbol=? msg 'add) add-new-node]
          [(symbol=? msg 'status) (status)]
          [(symbol=? msg 'raw) graph]
          [(symbol=? msg 'lookup) lookup-node]
          [(symbol=? msg 'change) change-connection]
          [(symbol=? msg 'route?) route-exists?]
          [(symbol=? msg 'isolate) isolate]
          [(symbol=? msg 'reset) (reset-visited-locations!)]
          [else (error 'make-simple-graph "Unknown message")])))

    (begin (register-connections connections) service-manager)))

;; TESTS
(define g (make-simple-graph '((A B) (B C) (C E) (D E) (E B))))
(g 'status)
((g 'lookup) 'C)
(equal? ((g 'route?) 'A 'C) true)
(equal? ((g 'route?) 'A 'F) false)
(equal? ((g 'route?) 'A 'D) false)
((g 'change) 'A 'D)
(equal? ((g 'route?) 'A 'D) true)
((g 'add) 'F)
(g 'status)
((g 'isolate) 'A)
(g 'status)
