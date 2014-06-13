(define-struct star (last first instrument sales))

(make-star 'Friedman 'Dan 'ukelele 19004)
(make-star 'Talcott 'Carolyn 'banjo 80000)
(make-star 'Harper 'Robert 'bagpipe 27860)

;; increment-sales : star  ->  star
;; to produce a star record like a-star with 20000 more sales 
(define (increment-sales a-star) 
  (make-star (star-last a-star)
             (star-first a-star)
             (star-instrument a-star)
             (+
               (star-sales a-star)
               20000)))

