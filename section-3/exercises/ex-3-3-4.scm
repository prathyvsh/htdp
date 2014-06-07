;; area-pipe : number number number -> number
;; Calculates the surface area of a pipe
(define (area-pipe-1 inner-radius length thickness)
  (+ (+ (lsa (+ inner-radius thickness) length)
     (lsa inner-radius length))
     (* 2 (hollow-disk-area inner-radius (+ inner-radius thickness)))))

;; lsa : number number -> number
;; Calculates lateral surface area of cylinder
(define (lsa radius height)
  (* (circumference-of-circle radius) height))

;; hollow-disk-area : number number -> number
;; Calculates area of hollow disk
(define (hollow-disk-area inner-radius outer-radius)
  (- (disk-area outer-radius)
     (disk-area inner-radius)))

;; disk-area : number -> number
;; Calculates area of disk
(define (disk-area radius)
  (* pi (sqr radius)))

;; circumference-of-circle : number -> number
;; Calculates circumference of a circle
(define (circumference-of-circle radius)
  (* 2 pi radius))

;: area-pipe-2 number number number -> number
;; With no functional decomposition
(define (area-pipe-2 inner-radius length thickness)
  (+ (* 2 (- (* pi (sqr (+ inner-radius thickness)))
     (* pi (sqr inner-radius))))
     (* 2 pi inner-radius length)
     (* 2 pi (+ inner-radius thickness) length)))
  
;; TESTS
(area-pipe-1 30 10 10)
(area-pipe-2 30 10 10)



