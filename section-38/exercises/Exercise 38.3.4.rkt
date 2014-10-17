;; NOTE
;; As is, the function has a semantic error
;; since the (second C) should be turned into
;; a function application with double brackets:
;; ((second C)) inorder to get the value of contents.

(define (make-box x)
  (local ((define contents x)
	  (define (new y) (set! contents y))
	  (define (peek) contents))
    (list new peek)))
(define B (make-box 55))
(define C B)

(and 
  (begin ((first B) 33) true) (= ((second C)) 33)
  (begin (set! B (make-box 44)) (= ((second C)) 33))) 

;; 

(define contents1 55)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define B (list new1 peek1))
(define C (list new1 peek1))

(and  (begin ((first (list new1 peek1)) 33) true) (= ((second C)) 33)
      (begin (set! B (make-box 44)) (= ((second C)) 33)))

;;

(define contents1 55)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define B (list new1 peek1))
(define C (list new1 peek1))

(and  (begin (new1 33) true) (= ((second C)) 33)
      (begin (set! B (make-box 44)) (= ((second C)) 33)))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define B (list new1 peek1))
(define C (list new1 peek1))

(and  (begin (void) true) (= ((second C)) 33)
      (begin (set! B (make-box 44)) (= ((second C)) 33)))

(and true (= ((second C)) 33)
      (begin (set! B (make-box 44)) (= ((second C)) 33)))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define B (list new1 peek1))
(define C (list new1 peek1))
(and true (= (peek1) 33)
     (begin (set! B (make-box 44)) (= ((second C)) 33)))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define B (list new1 peek1))
(define C (list new1 peek1))
(and true true (begin (set! B (make-box 44)) (= ((second C)) 33)))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define contents2 44)
(define (new2 y) (set! contents2 y))
(define (peek2) contents2)

(define B (list new2 peek2))
(define C (list new1 peek1))

(and true true (begin (set! B (make-box 44)) (= ((second C)) 33)))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define contents2 44)
(define (new2 y) (set! contents2 y))
(define (peek2) contents2)

(define B (list new2 peek2))
(define C (list new1 peek1))

(and true true (begin (void) (= ((second C)) 33)))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define contents2 44)
(define (new2 y) (set! contents2 y))
(define (peek2) contents2)

(define B (list new2 peek2))
(define C (list new1 peek1))

(and true true (begin (void) (= ((second C)) 33)))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define contents2 44)
(define (new2 y) (set! contents2 y))
(define (peek2) contents2)

(define B (list new2 peek2))
(define C (list new1 peek1))

(and true true (begin (void) (= (peek2) 33)))

;;

(and true true true)
true
