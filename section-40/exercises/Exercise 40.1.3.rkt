#lang racket
(require lang/htdp-advanced)

;; (define-struct movie (title producer))
(define (f-make-movie t p)
  (local ((define title t)
          (define producer p)
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'title) title]
             [(symbol=? msg 'producer) producer]
             [else (error 'movie "unknown message")]))) service-manager))

(define (f-movie-title mov) (mov 'title))
(define (f-movie-producer mov) (mov 'producer))

;; (define-struct boyfriend (name hair eyes phone))
(define (f-make-boyfriend n h e p)
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
            [else (error 'movie "unknown message")]))) service-manager))

(define (f-boyfriend-name bf) (bf 'name))
(define (f-boyfriend-hair bf) (bf 'hair))
(define (f-boyfriend-eyes bf) (bf 'eyes))
(define (f-boyfriend-phone bf) (bf 'phone))

;; (define-struct cheerleader (name number))
(define (f-make-cheerleader n num)
  (local ((define name n)
          (define number num)
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'name) name]
             [(symbol=? msg 'number) num]
             [else (error 'cheerleader "unknown message")])))
         service-manager))

(define (f-cheerleader-name c) (c 'name))
(define (f-cheerleader-number c) (c 'number))

;; (define-struct CD (artist title price))
(define (f-make-CD a t p)
  (local ((define artist a)
          (define title t)
          (define price p)
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'artist) artist]
             [(symbol=? msg 'title) title]
             [(symbol=? msg 'price) price]
             [else (error 'CD "unknown message")])))
         service-manager))

(define (f-CD-artist cd) (cd 'artist))
(define (f-CD-title cd) (cd 'title))
(define (f-CD-price cd) (cd 'price))

;; (define-struct sweater (material size producer))
(define (f-make-sweater m s p)
  (local ((define material m)
          (define size s)
          (define producer p)
          (define (service-manager msg)
            (cond
             [(symbol=? msg 'material) material]
             [(symbol=? msg 'size) size]
             [(symbol=? msg 'producer) producer]
             [else (error 'sweater "unknown message")])))
         service-manager))

(define (f-sweater-material s) (s 'material))
(define (f-sweater-size s) (s 'size))
(define (f-sweater-producer s) (s 'producer))

(define titanic (f-make-movie 'Titanic 'JamesCameron))
(f-movie-title titanic)
(f-movie-producer titanic)

(define james (f-make-boyfriend 'James 'Brown 'Green '03458))
(f-boyfriend-name james)
(f-boyfriend-hair james)
(f-boyfriend-eyes james)
(f-boyfriend-phone james)

(define sarah (f-make-cheerleader 'Sarah '239))
(f-cheerleader-name sarah)
(f-cheerleader-number sarah)

(define smiths (f-make-CD 'smiths 'smiths '27.99))
(f-CD-title smiths)
(f-CD-artist smiths)
(f-CD-price smiths)

(define hemsby (f-make-sweater 'wool 'M 'joules))
(f-sweater-material hemsby)
(f-sweater-size hemsby)
(f-sweater-producer hemsby)
