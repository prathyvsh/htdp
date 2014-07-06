(define-struct parent (children name eyes))

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

;; how-far-removed : a-parent -> number or boolean
;; Determines how far removed a blue eyed descendant is from the parent
(define (how-far-removed a-parent)
  (cond
    [(empty? a-parent) false]
    [(symbol=? (parent-eyes a-parent) 'blue) 0]
    [else (child-depth (parent-children a-parent))]))

;; child-depth : list-of-children -> number or boolean
;; Calculates the depth of a blue eyed child
(define (child-depth loc)
  (cond
    [(empty? loc) false]
    [else (get-min (increment-or-bool (how-far-removed (first loc))) (increment-or-bool (child-depth (rest loc))))]))

;; add-or-bool : number or boolean
;; Adds 1 to the given value in case the number is
;; not a boolean, returns false otherwise
(define (increment-or-bool value)
  (cond
  [(boolean? value) false]
  [else (+ 1 value)]))

;; min-or-bool : number or boolean
;; Returns the minimum of two numbers considering
;; the fact that the value incoming might be a boolean
(define (get-min value1 value2)
  (cond
    [(and (boolean? value1) (boolean? value2)) false]
    [(boolean? value1) value2]
    [(boolean? value2) value1]
    [else (min value1 value2)]))

;; TESTS
(= (how-far-removed Fred) 2)
(= (how-far-removed Joseph) 2)
(= (how-far-removed George) 0)
(boolean=? (how-far-removed August) false)
(= (how-far-removed James) 0)
(= (how-far-removed Jenna) 1)
(= (how-far-removed Rose) 2)
(boolean=? (how-far-removed Judith) false)
