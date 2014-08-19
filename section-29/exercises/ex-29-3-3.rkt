#lang racket
(require lang/htdp-intermediate-lambda)

;; A node is a symbol
;; A graph is
;; (vectorof (listof nodes))

;; neighbors-vec : node graph  ->  (listof node)
;; to lookup the node in graph
(define (neighbors-vec node graph)
  (vector-ref graph node))

;; find-route-vec : node node graph  ->  (listof node) or false
;; to create a path from origination to destination in G
;; if there is no path, the function produces false
(define (find-route-vec origination destination G)
  (cond
   [(= origination destination) (list destination)]
   [else (local ((define possible-route 
                   (find-route-vec/list (neighbors-vec origination G) destination G)))
           (cond
            [(boolean? possible-route) false]
            [else (cons origination possible-route)]))]))

;; find-route-vec/list : (listof node) node graph  ->  (listof node) or false
;; to create a path from some node on lo-Os to D
;; if there is no path, the function produces false
(define (find-route-vec/list lo-Os D G)
  (cond
   [(empty? lo-Os) false]
   [else (local ((define possible-route (find-route-vec (first lo-Os) D G)))
           (cond
            [(boolean? possible-route) (find-route-vec/list (rest lo-Os) D G)]
            [else possible-route]))]))

;; get-all-nodes-vec : graph -> (listof node)
;; Creates a list of all nodes in the given graph
(define (get-all-nodes-vec g)
  (build-list (vector-length g) (lambda (x) x)))

;; all-possible-permutations-vec : (listof symbol) -> (listof (listof symbol symbol))
;; Creates a list-of-all possible two letter permutations from the given graph
(define (all-possible-permutations-vec los)
  (couple-with-vec los los))

;; couple-with-vec (listof number) (listof number) -> (listof (listof number number))
;; Couples the entries of first list with the second one
(define (couple-with-vec los1 los2)
  (cond
   [(empty? los1) empty]
   [else (append (create-couple-vec (first los1) los2) (couple-with-vec (rest los1) los2))]))

;; create-couple-vec : number (listof number) -> (listof number number)
;; Couples the symbol with all the entries of the list
(define (create-couple-vec symbol los)
  (cond
   [(empty? los) empty]
   [else (cons (list symbol (first los)) (create-couple-vec symbol (rest los)))]))

;; all-routes : graph -> (listof node node)
;; Gets all the possible routes on the given Graph
(define (all-routes-vec g)
  (all-possible-permutations-vec (get-all-nodes-vec g)))

;; Simplified
;; test-on-all-nodes : graph -> (listof (listof node))
;; Tests routing between all nodes on the given graph
(define (test-on-all-nodes-vec g)
  (local ((define all-nodes (get-all-nodes-vec g)))
(map (lambda (start) (map (lambda (destination) (list start destination (find-route-vec start destination g))) all-nodes)) all-nodes)))


;; TESTS

(define cyclic-graph
  (vector '(1 4) '(4 5) '(1 3) '() '(2 5) '(4 6) '()))

(equal? (find-route-vec 1 2 cyclic-graph) '(1 4 2))
