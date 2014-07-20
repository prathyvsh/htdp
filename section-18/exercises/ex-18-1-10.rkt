#lang racket
;; A parent is a structure:
;;  (make-parent loc n e) 
;; where loc is a list of children, n and e are symbols.
(define-struct parent (children name eyes))

;; A list-of-children is either
;; empty or
;; (cons p loc) where p is a parent and loc is a list of children.

;; blue-eyed-descendant? : parent  ->  boolean
;; to determine whether a-parent any of the descendants (children, 
;; grandchildren, and so on) have 'blue in the eyes field
(define (blue-eyed-descendant? a-parent)
  (or (symbol=? (parent-eyes a-parent) 'blue)
      (local (
              ;; blue-eyed-children? : list-of-children  ->  boolean
              ;; to determine whether any of the structures in aloc is blue-eyed
              ;; or has any blue-eyed descendant
              (define (blue-eyed-children? aloc)
                (cond
                 [(empty? aloc) false]
                 [else (or (blue-eyed-descendant? (first aloc))
                           (blue-eyed-children? (rest aloc)))])))
        (blue-eyed-children? (parent-children a-parent)))))



;; TESTS
(define August (make-parent empty 'August 'green))
(define Bob (make-parent empty 'Bob 'green))
(define Ben (make-parent empty 'Ben 'brown))
(define George (make-parent empty 'George 'blue))
(define Tony (make-parent (list George) 'Tony 'black))
(define Rose (make-parent (list Tony) 'Rose 'grey))
(define James (make-parent (list Ben Bob) 'James 'blue))
(define Jenna (make-parent (list James) 'Jenna 'grey))
(define Malcom (make-parent (list James) 'Malcom 'brown))
(define Fred (make-parent (list Jenna Rose) 'Fred 'brown))
(define Tina (make-parent (list Rose Jenna) 'Martha 'blue))
(define Joseph (make-parent (list Tony) 'Joseph 'yellow))
(define Betty (make-parent (list George) 'Betty 'green))
(define Judith (make-parent (list Ben) 'Judith 'green))

(blue-eyed-descendant? Jenna)
