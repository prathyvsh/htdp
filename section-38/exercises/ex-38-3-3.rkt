#|
1. (define x 0)
(define (bump delta)
  (begin
    (set! x (+ x delta))
    x))
(+ (bump 2) (bump 3))

(define x 0)
(define (bump delta)
  (begin
    (set! x (+ x delta))
    x))

(+ (bump 2) (bump 3))

;;

(define x 0)
(+ (begin (set! x (+ 0 2)) x) (bump 3))

;;

(define x 0)
(+ (begin (set! x 2) x) (bump 3))

;;

(define x 2)
(+ 2 (bump 3))

;;

(define x 2)
(+ 2 (begin (set! x (+ 2 3)) x))

;; 

(define x 5)
(+ 2 5)

7


2. (define x 10)
(set! x (cond
         [(zero? x) 13]
         [else (/ 1 x)]))

(define x 10)
(set! x (cond
         [(zero? 10) 13]
         [else (/ 1 x)]))

(define x 10)
(set! x (/ 1 10))

(define x 1/10)
(void)


3. (define (make-box x)
     (local ((define contents x)
             (define (new y)
               (set! contents y))
             (define (peek)
               contents))
       (list new peek)))

(define B (make-box 55))
(define C (make-box 'a))

(begin
  ((first B) 33)
  ((second C)))

;; 


(define B (make-box 55))
(define C (make-box 'a))

(begin
  ((first (make-box 55)) 33)
  ((second (make-box 'a))))

;;
(begin
  ((first (local ((define contents 55)
                  (define (new y)
                    (set! contents y))
                  (define (peek)
                    contents))
            (list new peek))) 33)
  ((second (make-box 'a))))

;;

(begin
  ((first (local ((define contents 55)
                  (define (new y)
                    (set! contents y))
                  (define (peek)
                    contents))
            (list new peek))) 33)
  ((second (make-box 'a))))

;;

(define contents1 55)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(begin
  ((first (list new1 peek1)) 33)
  ((second (make-box 'a))))

;;

(define contents1 55)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)
(begin
  ((first (list (lambda (y) (set! contents1 y)) peek)) 33)
  ((second (make-box 'a))))

;; 
(define contents1 55)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(begin ((lambda (y) (set! contents1 y)) 33)
       ((second (make-box 'a))))

;;

(define contents1 55)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(begin (set! contents1 33)
       ((second (make-box 'a))))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(begin (void)
       ((second
         (local ((define contents 'a)
                 (define (new y)
                   (set! contents y))
                 (define (peek) contents))
           (list new peek)))))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define contents2 'a)
(define (new2 y) (set! contents2 y))
(define (peek2) contents2)

(begin (void) ((second (list new2 peek2))))

;;

(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define contents2 'a)
(define (new2 y) (set! contents2 y))
(define (peek2) contents2)

(begin (void) (peek2))

;;
(define contents1 33)
(define (new1 y) (set! contents1 y))
(define (peek1) contents1)

(define contents2 'a)
(define (new2 y) (set! contents2 y))
(define (peek2) contents2)

(begin (void) 'a)

;;

'a

|#
