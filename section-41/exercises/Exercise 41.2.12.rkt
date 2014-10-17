#lang racket
(require lang/htdp-advanced)

(define-struct square (nw length))

;; move-squares : (listof square) number -> (void)
;; Moves all the squares in the given list by delta amount
(define (move-squares los delta)
  (for-all-in-list los (lambda (x) (move-square! x delta))))

;; move-square! : square number -> (void)
;; Moves the square's x position by delta amount
(define (move-square! sq delta)
  (set-square-nw! sq (make-posn (+ delta (posn-x (square-nw sq))) (posn-y (square-nw sq)))))

;; An animal is
;; (make-struct symbol boolean boolean)
(define-struct animal (name fed-morning fed-evening))

;; feed-animal : animal symbol -> (void)
;; Sets the fed variable of the animal to be
;; true in the given feeding time
(define (feed-animal animal fed-time)
  (cond
   [(symbol=? fed-time 'morning) (set-animal-fed-morning! animal true)]
   [(symbol=? fed-time 'evening) (set-animal-fed-evening! animal true)]
   [else (error 'feed-animal "Unknown feeding time provided")]))

;; all-fed : (listof animal) -> (void)
;; Effect: Switches the morning fed field of
;; all animals to true
(define (all-fed loa)
  (for-all-in-list loa (lambda (x) (feed-animal x 'morning))))

;; for-all-in-list : (listof X) ((listof X) -> void) -> void
;; Perform a fn for all elments in the list
(define (for-all-in-list lst fn)
  (cond
   [(empty? lst) (void)]
   [else (begin (fn (first lst))
                (for-all-in-list (rest lst) fn))]))

;; TESTS
(define sq1 (make-square (make-posn 10 10) 30))
(define sq2 (make-square (make-posn 20 0) 40))
(move-squares (list sq1 sq2) 10)
(equal? sq1 (make-square (make-posn 20 10) 30))
(equal? sq2 (make-square (make-posn 30 0) 40))

(define zebra (make-animal 'Zebra false false))
(define hyena (make-animal 'Hyena false false))
(define hippopotamus (make-animal 'Hippo false true))
(define zoo-animals (list zebra hyena hippopotamus))

(begin (all-fed zoo-animals)
(andmap (lambda (x) (equal? (animal-fed-morning x) true)) zoo-animals))
