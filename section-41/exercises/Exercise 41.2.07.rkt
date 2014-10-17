#lang racket
(require lang/htdp-advanced)

(define-struct CD (price title artist))
(define-struct record (price antique title artist))
(define-struct DVD (price title artist to-appear))
(define-struct tape (price title artist))

;; A music-item is either
;; a CD or a record or a DVD or a tape

;; inflate! : music-item number -> void
;; Increases the price of the music-item by price
(define (inflate! item percentage)
   (set-item-price! item percentage))

;; set-item-price! : music-item number -> void
;; Sets the item price according to the type of the item
;; passed in
(define (set-item-price! item percentage)
  (local ((define price (item-price item))
   (define increase (+ (* (/ percentage 100) price) price)))
  (cond
   [(CD? item) (set-CD-price! item increase)]
   [(record? item) (set-record-price! item increase)]
   [(DVD? item) (set-DVD-price! item increase)]
   [(tape? item) (set-tape-price! item increase)]
   [else (error 'set-item-price! "Unknow item")])))


;; item-price : music-item -> number
;; Collects the price from the given item
(define (item-price item)
  (cond
   [(CD? item) (CD-price item)]
   [(record? item) (record-price item)]
   [(DVD? item) (DVD-price item)]
   [(tape? item) (tape-price item)]
   [else (error 'item-price "Unknown item")]))

;; TESTS
(define cd (make-CD 20 'BlueMoon 'Marquest))
(inflate! cd 5)
(equal? cd (make-CD 21 'BlueMoon 'Marquest))
