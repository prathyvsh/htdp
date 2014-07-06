;; A parent is a structure:
;;  (make-parent loc n e) 
;; where loc is a list of children, n and e are symbols.
;;
;; A list-of-children is either
;; empty or
;; (cons p loc) where p is a parent and loc is a list of children.
(define-struct parent (children name eyes))

;; eye-colors : parent -> list-of-symbols
;; Creates a list of all eye colors in a family tree
(define (eye-colors p)
  (cond
  [(empty? p) empty]
  [else (append (list (parent-eyes p)) (child-eye-color (parent-children p)))]))

;; child-eye-color : list-of-children -> list-of-symbols
;; Creates a list of eye color of children
(define (child-eye-color loc)
  (cond
    [(empty? loc) empty]
    [else (append (eye-colors (first loc)) (child-eye-color (rest loc)))]))

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

(eye-colors George) "should be" (list 'blue) "***"
(eye-colors Joseph) "should be" (list 'yellow 'black 'blue)
(eye-colors Fred) "should be" (list 'brown 'grey 'blue 'brown 'green 'black 'blue)
