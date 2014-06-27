;; red-balloons : number -> true
;; Visualizes random red balloons on a grid
(define (student-riot count)
  (and (draw-balloons (balloon-locations count 5) 5 'red)
       (draw-grid rows cols)))

;; balloon-locations : number -> list-of-posns
;; Creates balloons at random locations in the canvas
(define (balloon-locations count size)
  (make-random-posns size (- canvas-size size) count))

;; random-n-m : integer integer -> integer
;; Creates a number between n and m
;; Assume n < m
(define (random-n-m n m)
  (+ (random (- m n)) n))

;; make-random-posns : count -> list-of-posns
;; Creates a list of posns with given count of posns
(define (make-random-posns low high count)
  (cond
    [(zero? count) empty]
    [else (cons (make-posn (random-n-m low high) (random-n-m low high))
                (make-random-posns low high (sub1 count)))]))

;; draw-balloons : list-of-posns number symbol -> true
;; Draws balloons at given locations with given radius and color
(define (draw-balloons lop radius color)
  (cond
    [(empty? lop) true]
    [else (and (draw-solid-disk (first lop) radius color)
               (draw-balloons (rest lop) radius color))]))

;; draw-grid number number -> true
;; Draws a column with given number of row-count and column-count
(define (draw-grid row-count column-count)
  (and (draw-horizontal-lines row-count canvas-size (/ canvas-size row-count))
       (draw-vertical-lines column-count canvas-size (/ canvas-size column-count))))

;; draw-horizontal-lines number number number -> true
;; Draws set of horizontal-lines of given count that spans canvas-size and is set div-size apart
(define (draw-horizontal-lines count canvas-size div-size)
  (cond
    [(zero? count) true]
    [else (and (draw-solid-line (make-posn 0 (* count div-size))
                                (make-posn canvas-size (* count div-size)))
               (draw-horizontal-lines (sub1 count) canvas-size div-size))]))


;; draw-vertical-line number number number -> true
;; Draws set of horizontal-lines of given count that spans canvas-size and is set div-size apart
(define (draw-vertical-lines count canvas-size div-size)
  (cond
    [(zero? count) true]
    [else (and (draw-solid-line (make-posn (* count div-size) 0)
                                (make-posn (* count div-size) size))
               (draw-vertical-lines (sub1 count) canvas-size div-size))]))

;; TESTS
(define canvas-size 300)
(define rows 5)
(define cols 8)
(start canvas-size canvas-size)
(define balloon-radius 10)
(student-riot 10)
