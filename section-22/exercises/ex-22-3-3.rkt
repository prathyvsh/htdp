#lang racket
(require htdp/gui)
(require lang/htdp-intermediate)

#|
;; DATA DEFINITION
A cell is either
1. a number,
2. a symbol.

A gui-table is a (listof (listof cell))
|#

(define screen-message (make-message "N"))

;; pad->gui : string gui-table -> (listof (listof gui-items))
(define (pad->gui title table)
  (append (list (list (make-message title)) (list screen-message)) (convert-cells table)))

(define (convert-cells cells)
   (local ((define (row-converter r) (map cell->element r)))
     (map row-converter cells)))

(define (cell->element cell)
  (local ((define button-as-string
            (cond
             [(symbol? cell) (symbol->string cell)]
             [(number? cell) (number->string cell)]))
          (define (display-callback e) (draw-message screen-message button-as-string)))
    (make-button button-as-string display-callback)))

(define pad
  '((1 2 3)
    (4 5 6)
    (7 8 9)
    (\# 0 *)))

(define pad2 
  '((1 2 3  +)
    (4 5 6  -)
    (7 8 9  *)
    (0 = \. /)))

;;(create-window (pad->gui "Virtual Phone" pad))
(create-window (pad->gui "Calculator" pad2))
