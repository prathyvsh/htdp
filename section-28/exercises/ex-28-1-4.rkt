#lang racket
(require lang/htdp-intermediate-lambda)

;; neighbors : node graph -> (listof nodes)
;; Finds the neighbors of the node
(define (neighbors n g)
  (cond
   [(empty? g) empty]
   [(symbol=? n (first (first g))) (second (first g))]
   [else (neighbors n (rest g))]))

;; find-route : node node graph  ->  (listof node) or false
;; to create a path from origination to destination in G
;; if there is no path, the function produces false
(define (find-route origination destination G)
  (cond
   [(symbol=? origination destination) (list destination)]
   [else (local ((define possible-route 
                   (find-route/list (neighbors origination G) destination G)))
           (cond
            [(boolean? possible-route) false]
            [else (cons origination possible-route)]))]))

;; find-route/list : (listof node) node graph  ->  (listof node) or false
;; to create a path from some node on lo-Os to D
;; if there is no path, the function produces false
(define (find-route/list lo-Os D G)
  (cond
   [(empty? lo-Os) false]
   [else (local ((define possible-route (find-route (first lo-Os) D G)))
           (cond
            [(boolean? possible-route) (find-route/list (rest lo-Os) D G)]
            [else possible-route]))]))


;; get-all-nodes : graph -> (listof node)
;; Creates a list of all nodes in the given graph
(define (get-all-nodes g)
  (map (lambda (x) (first x)) g))

;; all-possible-permutations : (listof symbol) -> (listof (listof symbol symbol))
;; Creates a list-of-all possible two letter permutations from the given graph
(define (all-possible-permutations los)
  (couple-with los los))

;; couple-with (listof symbol) (listof symbol) -> (listof (listof symbol symbol))
;; Couples the entries of first list with the second one
(define (couple-with los1 los2)
  (cond
   [(empty? los1) empty]
   [else (append (create-couple (first los1) los2) (couple-with (rest los1) los2))]))

;; create-couple : symbol (listof symbol) -> (listof symbol symbol)
;; Couples the symbol with all the entries of the list
(define (create-couple symbol los)
  (cond
   [(empty? los) empty]
   [else (cons (list symbol (first los)) (create-couple symbol (rest los)))]))

;; all-routes : graph -> (listof node node)
;; Gets all the possible routes on the given Graph
(define (all-routes g)
  (all-possible-permutations (get-all-nodes g)))

;; test-on-all-nodes : graph -> (listof (listof node))
;; Tests routing between all nodes on the given graph
(define (test-on-all-nodes g)
(map (lambda (x) (find-route (first x) (second x) g)) (all-routes g)))


;; Simplified
;; test-on-all-nodes : graph -> (listof (listof node))
;; Tests routing between all nodes on the given graph
(define (test-on-all-nodes g)
  (local ((define all-nodes (get-all-nodes g)))
(map (lambda (start) (map (lambda (destination) (list start destination (find-route start destination g))) all-nodes)) all-nodes)))

;; TESTS

(define Graph '((A (B E)) (B (E F)) (C (D)) (D ()) (E (C F)) (F (D G)) (G ())))

(equal? (get-all-nodes Graph) '(A B C D E F G))
(equal? (create-couple 'A (list 'B 'C)) '((A B) (A C)))
(equal? (all-possible-permutations (list 'A 'B)) '((A A) (A B) (B A) (B B)))
(equal? (all-possible-permutations (list 'A 'B 'C)) '((A A) (A B) (A C) (B A) (B B) (B C) (C A) (C B) (C C)))

(test-on-all-nodes Graph)
