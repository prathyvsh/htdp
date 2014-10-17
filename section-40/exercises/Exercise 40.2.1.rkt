#lang racket
(require lang/htdp-advanced)

;; (define-struct boyfriend (name hair eyes phone))
(define (fm-make-boyfriend n h e p)
  (local ((define name n)
            (define hair h)
            (define eyes e)
            (define phone p)
         (define (service-manager msg)
           (cond
            [(symbol=? msg 'name) name]
            [(symbol=? msg 'hair) hair]
            [(symbol=? msg 'eyes) eyes]
            [(symbol=? msg 'phone) phone]
            [(symbol=? msg 'set-name) (lambda (new-name) (set! name new-name))]
            [(symbol=? msg 'set-hair) (lambda (new-hair) (set! hair new-hair))]
            [(symbol=? msg 'set-eyes) (lambda (new-eyes) (set! eyes new-eyes))]
            [(symbol=? msg 'set-phone) (lambda (new-phone) (set! phone new-phone))]
            [else (error 'movie "unknown message")]))) service-manager))

(define (fm-boyfriend-name bf) (bf 'name))
(define (fm-boyfriend-hair bf) (bf 'hair))
(define (fm-boyfriend-eyes bf) (bf 'eyes))
(define (fm-boyfriend-phone bf) (bf 'phone))

(define (fm-set-boyfriend-name! bf new) ((bf 'set-name) new))
(define (fm-set-boyfriend-hair! bf new) ((bf 'set-hair) new))
(define (fm-set-boyfriend-eyes! bf new) ((bf 'set-eyes) new))
(define (fm-set-boyfriend-phone! bf new) ((bf 'set-phone) new))

(define tony (fm-make-boyfriend 'Tony 'Blonde 'Grey '0832323))

(fm-set-boyfriend-phone! tony '032823234)
(equal? (fm-boyfriend-phone tony) '032823234)
