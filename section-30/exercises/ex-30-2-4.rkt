#lang racket
(require lang/htdp-intermediate-lambda)

;; find-route : node node graph  ->  (listof node) or false
;; to create a path from origination to destination in G
;; if there is no path, the function produces false
(define (find-route origination destination G)
  (local (
          ;; find-route/list : (listof node) node (listof node) graph  ->  (listof node) or false
          ;; to create a path from some node on lo-Os to D
          ;; if there is no path, the function produces false
          (define (find-route/list lo-Os D seen-places G)
            (cond
             [(empty? lo-Os) false]
             [else (local ((define first-place (first lo-Os)))
                     (cond [(contains? first-place seen-places) false]
                           [else (local ((define new-seen-places (cons first-place seen-places))
                                         (define possible-route (search-route new-seen-places (first lo-Os) D G)))
                                   (cond
                                    [(boolean? possible-route) (find-route/list (rest lo-Os) D new-seen-places G)]
                                    [else possible-route]))]))]))
          (define (search-route seen-places origination destination G)
            (cond
             [(symbol=? origination destination) (list destination)]
             [else (local ((define possible-route
                             (find-route/list (neighbors origination G) destination (cons origination seen-places) G)))
                     (cond
                      [(boolean? possible-route) false]
                      [else (cons origination possible-route)]))])))
    (search-route empty origination destination G)))


;; contains? : symbol (listof symbol) -> boolean
;; Determines if the list contains the symbol
(define (contains? sym l)
  (ormap (lambda (x) (symbol=? sym x)) l))

;; neighbors : node graph -> (listof nodes)
;; Finds the neighbors of the node
(define (neighbors n g)
  (cond
   [(empty? g) empty]
   [(symbol=? n (first (first g))) (second (first g))]
   [else (neighbors n (rest g))]))

;; TESTS
(define graph 
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define cyclic-graph
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

;; get-all-nodes : graph -> (listof node)
;; Creates a list of all nodes in the given graph
(define (get-all-nodes g)
  (map (lambda (x) (first x)) g))

;; test-on-all-nodes : graph -> (listof (listof node))
;; Tests routing between all nodes on the given graph
(define (test-on-all-nodes g)
  (local ((define all-nodes (get-all-nodes g)))
    (map (lambda (start) (map (lambda (destination) (list start destination (find-route start destination g))) all-nodes)) all-nodes)))

(equal? (find-route 'B 'C cyclic-graph) '(B E C))
(equal? (find-route 'B 'X cyclic-graph) false)
(equal? (find-route 'B 'D cyclic-graph) '(B E F D))
(test-on-all-nodes graph)
(test-on-all-nodes cyclic-graph)
