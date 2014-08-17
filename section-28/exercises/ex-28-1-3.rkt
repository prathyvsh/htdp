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

;; TESTS

(define Graph '((A (B E)) (B (E F)) (C (D)) (D ()) (E (C F)) (F (D G)) (G ())))
(equal? (find-route 'A 'G Graph) '(A B E F G))
(equal? (find-route 'C 'G Graph) false)
