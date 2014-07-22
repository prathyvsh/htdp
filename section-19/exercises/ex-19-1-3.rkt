;; FUNCTION DEFINITIONs

;; squared>? : number number  ->  boolean
(define (squared>? x c)
  (> (* x x) c))

(define (filter1 rel-op alon t)
  (cond
   [(empty? alon) empty]
   [else (cond
          [(rel-op (first alon) t) 
           (cons (first alon)
                 (filter1 rel-op (rest alon) t))]
          [else (filter1 rel-op (rest alon) t)])]))

(filter1 squared>? (list 4 5) 10) = (cons 4 (filter1 squared>? (list 5) 10))

(cond
 [(empty? (list 4 5)) empty]
 [else (cond
        [(squared>? (first (list 4 5)) 10) 
         (cons (first (list 4 5))
               (filter1 squared>? (rest (list 4 5)) 10))]
        [else (filter1 squared>? (rest (list 4 5)) 10)])]))
(cond
 [false empty]
 [else (cond
        [(squared>? (first (list 4 5)) 10) 
         (cons (first (list 4 5))
               (filter1 squared>? (rest (list 4 5)) 10))]
        [else (filter1 squared>? (rest (list 4 5)) 10)])]))

(cond
 [(squared>? (first (list 4 5)) 10) 
  (cons (first (list 4 5))
        (filter1 squared>? (rest (list 4 5)) 10))]
 [else (filter1 squared>? (rest (list 4 5)) 10)])


(cond
 [(squared>? 4 10) 
  (cons (first (list 4 5))
        (filter1 squared>? (rest (list 4 5)) 10))]
 [else (filter1 squared>? (rest (list 4 5)) 10)])

(cond
 [ (> (* 4 4) 10)
   (cons (first (list 4 5))
         (filter1 squared>? (rest (list 4 5)) 10))]
 [else (filter1 squared>? (rest (list 4 5)) 10)])

(cond
 [ (> 16 10)
   (cons (first (list 4 5))
         (filter1 squared>? (rest (list 4 5)) 10))]
 [else (filter1 squared>? (rest (list 4 5)) 10)])

(cond
 [true
   (cons (first (list 4 5))
         (filter1 squared>? (rest (list 4 5)) 10))]
 [else (filter1 squared>? (rest (list 4 5)) 10)])

(cons (first (list 4 5)) (filter1 squared>? (rest (list 4 5)) 10))

(cons 4 (filter1 squared>? (rest (list 4 5)) 10))

(cons 4 (filter1 squared>? (list 5) 10))

;;QED
