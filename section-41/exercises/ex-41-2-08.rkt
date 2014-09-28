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

;; TESTS
(define zebra (make-animal 'Zebra false false))
(feed-animal zebra 'morning)
(equal? zebra (make-animal 'Zebra true false))

(define hyena (make-animal 'Hyena false false))
(feed-animal hyena 'evening)
(equal? hyena (make-animal 'Hyena false true))

(define hippopotamus (make-animal 'Hippo false true))
(feed-animal hippopotamus 'morning)
(feed-animal hippopotamus 'evening)
(equal? hippopotamus (make-animal 'Hippo true true))
