#lang racket
(require lang/htdp-beginner)

(define-struct movie (title producer))
(define sucky (make-movie 'transformers 'spielberg))
(movie-title sucky)
(movie-producer sucky)


(define-struct boyfriend (name hair eyes phone))
(define prince (make-boyfriend 'Mark 'Ginger 'Green '07-2323223))
(boyfriend-name prince)
(boyfriend-hair prince)
(boyfriend-eyes prince)
(boyfriend-phone prince)

(define-struct cheerleader (name number))
(define tigress (make-cheerleader 'Sarah '23-2342-342))
(cheerleader-name tigress)
(cheerleader-number tigress)

(define-struct CD (artist title price))
(define favourite (make-CD 'SigurRos 'Valtari '25p))
(CD-artist favourite)
(CD-title favourite)
(CD-price favourite)

(define-struct sweater (material size producer))
(define furball (make-sweater 'wool 'M 'Joules))
(sweater-material furball)
(sweater-size furball)
(sweater-producer furball)

