(define Graph 
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define Graph (list (list 'A (list 'B 'E))
                    (list 'B (list 'E 'F))
                    (list 'C (list 'D))
                    (list 'D empty)
                    (list 'E (list 'C 'F))
                    (list 'F (list 'D 'G))
                    (list 'G empty)))

;; A node is a symbol
;; A graph is
;; (listof (list node (listof nodes)))
