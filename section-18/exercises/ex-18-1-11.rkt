;; last-occurrence : symbol list-of-star -> star or false
;; to find the last star record in alostars that contains s in name field
(define (last-occurrence s alostars)
  (cond
   [(empty? alostars) false]
   [else (local ((define r (last-occurrence s (rest alostars))))
           (cond
            [(star? r) r]
            [(symbol=? (star-name (first alostars)) s) (first alostars)] [else false]))]))

(last-occurrence 'Matt
                 (list (make-star 'Matt 'violin)
                       (make-star 'Matt 'radio)))

(define mv (make-star 'Matt 'violin))
(define mr (make-star 'Matt 'radio))

(last-occurrence 'Matt (list (mv mr)))

(cond
 [(empty? (list mv mr)) false]
 [else (local ((define r (last-occurrence 'Matt (rest (list mv mr)))))
         (cond
          [(star? r) r]
          [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
          [else false]))])

(cond
 [false false]
 [else (local ((define r (last-occurrence 'Matt (rest (list mv mr)))))
         (cond
          [(star? r) r]
          [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
          [else false]))])

(local ((define r (last-occurrence 'Matt (rest (list mv mr)))))
  (cond
   [(star? r) r]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false]))

(define r1 (last-occurrence 'Matt (list mr)))
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])


(define r1 (cond
            [(empty? (list mr)) false]
            [(else (local ((define r (last-occurrence 'Matt (rest (list mr)))))
                     (cond
                      [(star? r) r]
                      [(symbol=? (star-name (first (list mr))) 'Matt) (first (list mr))]
                      [else false])))]))
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])

(define r1 (cond
            [false false]
            [(else (local ((define r (last-occurrence 'Matt (rest (list mr)))))
                     (cond
                      [(star? r) r]
                      [(symbol=? (star-name (first (list mr))) 'Matt) (first (list mr))]
                      [else false])))]))
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])



(define r1
  (local ((define r (last-occurrence 'Matt (rest (list mr)))))
                     (cond
                      [(star? r) r]
                      [(symbol=? (star-name (first (list mr))) 'Matt) (first (list mr))]
                      [else false])))
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])


;;;;;;;;;

(define r2 (last-occurence 'Matt empty))
(define r1 (cond
            [(star? r2) r2]
            [(symbol=? (star-name mr) 'Matt) mr]
            [else false]))
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])

(define r2 false)
(define r1 (cond
            [(star? false) false]
            [(symbol=? (star-name mr) 'Matt) mr]
            [else false]))
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])


(define r1 (cond
            [false false]
            [true mr]
            [else false]))
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])

(define r1 mr)
  (cond
   [(star? r1) r1]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])

  (cond
   [(star? mr) mr]
   [(symbol=? (star-name (first (list mv mr))) 'Matt) (first (list mv mr))]
   [else false])

mr ;; which is
(make-star 'Matt 'radio)

;; 2 local definitions have been lifted
