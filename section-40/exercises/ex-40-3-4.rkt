(define-struct cheerleader (name number))

(define A (make-cheerleader 'JoAnn 2))

(define B (make-cheerleader 'Belle 1))

(define C (make-cheerleader 'Krissy 1)) 

(define all (list A B C))

(list
  (cheerleader-number (second all))
  (begin
    (set-cheerleader-number! (second all) 17)
    (cheerleader-number (second all))))

;; EVALUATION

(list (cheerleader-number (second (list A B C)))
      (begin
        (set-cheerleader-number! (second (list A B C)) 17)
        (cheerleader-number (second (list A B C)))))

(list (cheerleader-number B)
      (begin
        (set-cheerleader-number! (second (list A B C)) 17)
        (cheerleader-number (second (list A B C)))))

(list 1
      (begin
        (set-cheerleader-number! B 17)
        (cheerleader-number (second (list A B C)))))


(define A (make-cheerleader 'JoAnn 2))
(define B (make-cheerleader 'Belle 17))
(define C (make-cheerleader 'Krissy 1)) 
(list 1 (begin (void) (cheerleader-number B)))

(list 1 17)

;; Only definition that changed is that of B.
