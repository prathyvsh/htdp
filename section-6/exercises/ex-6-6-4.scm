;;circle ->
(define-struct circle (center radius color))

;; TEMPLATE
;;(define (fun-for-circle a-circle)
;;  ... (circle-center a-circle) ...
;;  ... (circle-radius a-circle) ...
;;  ... (circle-perimeter a-circle) ...)

;; distance-between : position position -> number
;; Calculates the distance between two points 
(define (distance-between posn1 posn2)
(sqrt  (+ (sqr (- (posn-x posn2) (posn-x posn1))) (sqr (- (posn-y posn2) (posn-y posn1))))))


;; move-right : position number -> point
;; Moves point p to the right x pixels
(define (move-right p x)
  (make-posn (+ x (posn-x p)) (posn-y p)))

;; translate-circle circle number -> circle
;; Moves circle to the right by the given delta value
(define (translate-circle circle delta)
  (make-circle (move-right (circle-center circle) delta)
               (circle-radius circle)
               (circle-color circle)))

;;TESTS

(define center1 (make-posn 6 2))
(define radius1 1)
(define circle1 (make-circle center1 radius1 'red))
(define new-circle (translate-circle circle1 20))
(define new-circle-2 (translate-circle circle1 42))
(= (posn-x (circle-center new-circle)) 26)
(= (posn-x (circle-center new-circle-2)) 48)
