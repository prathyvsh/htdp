
;; below-ir : number loIR  ->  loIR
;; to construct a list of those records 
;; on aloir that contain a price below t
(define (below aloir t)
  (cond
    [(empty? aloir) empty]
    [else (cond
	    [(<ir (first aloir) t) 
	     (cons (first aloir)
	      (below-ir (rest aloir) t))]
	    [else
	      (below-ir (rest aloir) t)])]))

;; <ir : IR number  ->  boolean
(define (<ir ir p)
    (< (ir-price ir) p))

(define (below-ir1 aloir t)
  (filter1 <ir aloir t))


(below-ir1 10 (list (make-ir 'doll 8) (make-ir 'robot 12)))

(below-ir1 10 (list (make-ir 'doll 8) (make-ir 'robot 12)))
(filter1 <ir (list (make-ir 'doll 8) (make-ir 'robot 12)) 10)
(filter1 <ir (list (make-ir 'robot 12)) 10)
(cons 12 (filter1 <ir empty 10))
(cons 12 empty)

;; find : loIR symbol  ->  boolean
;; to determine whether aloir contains a record for t
(define (find aloir t)
  (cons? (filter1 eq-ir? aloir t)))

;; eq-ir? : IR symbol  ->  boolean
;; to compare ir's name and p
(define (eq-ir? ir p)
  (symbol=? (ir-name ir) p))

(find 'doll (list (make-ir 'doll 8) (make-ir 'robot 12) (make-ir 'doll 13)))
(cons? (filter1 eq-ir? (list (make-ir 'doll 8) (make-ir 'robot 12) (make-ir 'doll 13)) 'doll))
(cons? (cons (make-ir 'doll 8) (filter1 eq-ir? (list (make-ir 'robot 12) (make-ir 'doll 13)) 'doll)))
(cons? (cons (make-ir 'doll 8) (filter1 eq-ir? (list (make-ir 'doll 13)) 'doll)))
(cons? (cons (make-ir 'doll 8) (cons (make-ir 'doll 13) (filter1 eq-ir? empty 'doll))))
(cons? (cons (make-ir 'doll 8) (cons (make-ir 'doll 13) empty)))
true

