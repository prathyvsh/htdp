;; A parent is a structure:
;;  (make-parent loc n e) 
;; where loc is a list of children, n and e are symbols.
;;
;; A list-of-children is either
;; empty or
;; (cons p loc) where p is a parent and loc is a list of children.
(define-struct parent (children name eyes))

;; count-descendants : parent -> number
;; Counts the number of descendants of parent has including the parent.
(define (count-descendants parent)
  (cond
    [(empty? parent) 0]
    [else (+ 1 (count-child-descendants (parent-children parent)))]))

;; count-child-descendants: list-of-children -> number
;; Counts the number of descendants in the child list
(define (count-child-descendants loc)
  (cond
    [(empty? loc) 0]
    [else (+ (count-descendants (first loc)) (count-child-descendants (rest loc)))]))

;;count-proper-descendants : parent -> number
;; Counts the number of descandants of parent excluding the parent.
(define (count-proper-descendants-alt2 parent)
  (cond
    [(empty? parent) 0]
    [else (count-proper-child-descendants (parent-children parent))]))

(define (count-proper-descendants-alt1 parent)
  (- (count-descendants parent) 1))

(define (count-proper-descendants parent)
  (count-child-descendants (parent-children parent)))

;; count-proper-child-descendants: list-of-children -> number
;; Counts the number of descendants in the child list excluding the parent.
(define (count-proper-child-descendants loc)
  (cond
    [(empty? loc) 0]
    [else (+ (count-proper-descendants (first loc)) (+ 1 (count-proper-child-descendants (rest loc))))]))

;; TESTS
(define August (make-parent empty 'August 'green))
(define Bob (make-parent empty 'Bob 'green))
(define Ben (make-parent empty 'Ben 'brown))
(define George (make-parent empty 'George 'blue))
(define Tony (make-parent (list George) 'Tony 'black))
(define Rose (make-parent (list Tony) 'Rose 'grey))
(define James (make-parent (list Ben Bob) 'James 'blue))
(define Jenna (make-parent (list James) 'Jenna 'Grey))
(define Malcom (make-parent (list James) 'Malcom 'brown))
(define Fred (make-parent (list Jenna Rose) 'Fred 'brown))
(define Tina (make-parent (list Rose Jenna) 'Martha 'blue))
(define Joseph (make-parent (list Tony) 'Joseph 'yellow))
(define Betty (make-parent (list George) 'Betty 'green))
(define Judith (make-parent (list Ben) 'Judith 'green))

(= (count-descendants George) 1)
(= (count-descendants Tony) 2)
(= (count-descendants Betty) 2)
(= (count-descendants Joseph) 3)
(= (count-descendants Rose) 3)
(= (count-descendants Fred) 8)
(= (count-descendants Tina) 8)
(= (count-descendants Jenna) 4)

(= (count-proper-descendants George) 0)
(= (count-proper-descendants Tony) 1)
(= (count-proper-descendants Betty) 1)
(= (count-proper-descendants Joseph) 2)
(= (count-proper-descendants Rose) 2)
(= (count-proper-descendants Fred) 7)
(= (count-proper-descendants Tina) 7)
(= (count-proper-descendants Jenna) 3)
