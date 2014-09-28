#lang racket
(require lang/htdp-advanced)

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
  (cond
   [(empty? loa) (void)]
   [else (begin (feed-animal (first loa) 'morning)
           (all-fed (rest loa)))]))
  
;; TESTS
(define zebra (make-animal 'Zebra false false))
(define hyena (make-animal 'Hyena false false))
(define hippopotamus (make-animal 'Hippo false true))
(define zoo-animals (list zebra hyena hippopotamus))

(begin (all-fed zoo-animals)
(andmap (lambda (x) (equal? (animal-fed-morning x) true)) zoo-animals))

