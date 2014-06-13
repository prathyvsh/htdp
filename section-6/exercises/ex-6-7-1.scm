(define PLANK-HORIZONTAL-WIDTH 100)
(define NOOSE-VERTICAL-HEIGHT 30)
(define plank-start (make-posn 0 10))
(define plank-end (make-posn (+ (posn-x plank-start) PLANK-HORIZONTAL-WIDTH) (posn-y plank-start)))
(define noose-start (make-posn (posn-x plank-end) (posn-y plank-end)))
(define noose-end (make-posn (posn-x noose-start) (+ (posn-y noose-start) NOOSE-VERTICAL-HEIGHT)))
(define head-radius 10)
(define head-location (make-posn (posn-x noose-end) (+ (posn-y noose-end) head-radius)))
(define body-height 50)
(define body-start (make-posn (posn-x head-location) (+ (posn-y head-location) head-radius)))
(define body-end (make-posn (posn-x body-start) (+ (posn-y body-start) body-height)))

;; AUXILARY FUNCTIONS
;; circle is a structure
;; make-circle position number symbol
(define-struct circle (center radius color))

;; draw-a-circle : circle -> true
;; Draws a give circle on screen
(define (draw-a-circle c)
  (draw-circle (circle-center c) (circle-radius c) (circle-color c)))

;; draw-plank : position position -> true
;; Draws a horizontal plank from start to end
(define (draw-plank start end)
  (draw-solid-line start end 'black))

(define (draw-noose start end)
  (draw-solid-line start end 'black))

(define (draw-head location)
  (draw-a-circle (make-circle location head-radius 'black)))

(define (draw-body start end)
  (draw-solid-line start end 'black))

;; draw-next-part : symbol -> true
(define (draw-next-part organ) ...)

;; TESTS
(start 200 200)
(draw-plank plank-start plank-end)
(draw-noose noose-start noose-end)
(draw-head head-location)
(draw-body body-start body-end)
