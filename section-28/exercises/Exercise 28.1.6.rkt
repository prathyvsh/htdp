#lang racket
(require lang/htdp-intermediate-lambda)

;; find-route : node node graph  ->  (listof node) or false
;; to create a path from origination to destination in G
;; if there is no path, the function produces false
(define (find-route origination destination G)
  (cond
   [(symbol=? origination destination) (list destination)]
   [else (local (
                 ;; neighbors : node graph -> (listof nodes)
                 ;; Finds the neighbors of the node
                 (define (neighbors n g)
                   (cond
                    [(empty? g) empty]
                    [(symbol=? n (first (first g))) (second (first g))]
                    [else (neighbors n (rest g))]))
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
                 (define neighborhood (neighbors origination G))
                 (define possible-route (find-route/list neighborhood destination G))
                 )
           (cond
            [(boolean? possible-route) false]
            [else (cons origination possible-route)]))]))

;; TESTS
(define cyclic-graph
  '((A (B E))
    (B (E F))
    (C (B D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(equal? (find-route 'B 'C cyclic-graph) '(B E C))
