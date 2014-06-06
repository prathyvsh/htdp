(define (somef x)
  (sin x x))

(somef 10 20)
;Error: Somef only expects one argument

(somef 10)
;Error: Sin only expects one arguments
