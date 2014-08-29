;; Run this in DrRacket

(define inex (+ 1 #i1e-12))
(define exac (+ 1 1e-12))

;; my-expt : number number -> number
(define (my-expt n m)
  (expt n m))

(my-expt inex 30)
;#i1.0000000000300027

(my-expt exac 30)
;1.0000000000300000000004350...

;; The exact one has more precision.
;; But usefulness as mentioned in the
;; text is probably context dependent.

