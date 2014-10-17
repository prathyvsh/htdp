#lang racket
(require lang/htdp-beginner)

;; movie-template : movie -> ???
(define (movie-template a-movie)
... (movie-title a-movie) ...
... (movie-producer a-movie) ...)

;; boyfriend-template : boyfriend -> ???
(define (boyfriend-template a-boy)
  ... (boyfriend-name a-boy) ...
  ... (boyfriend-hair a-boy) ...
  ... (boyfriend-eyes a-boy) ...
  ... (boyfriend-phone a-boy) ...)

;; cheerleader-template : cheerleader -> ???
(define (cheerleader-template cheerleader)
  ... (cheerleader-name cheerleader) ...
  ... (cheerleader-number cheerleader) ...)

;; CD-template : CD -> ???
(define (CD-template cd)
  ... (CD-artist cd) ...
  ... (CD-title cd) ...
  ... (CD-price cd) ...)

;; sweater-template : sweater -> ???
(define (sweater-template a-sweater)
  ... (sweater-material a-sweater) ...
  ... (sweater-size a-sweater) ...
  ... (sweater-producer a-sweater) ...)

(define-struct movie (title producer))
(define-struct boyfriend (name hair eyes phone))
(define-struct cheerleader (name number))
(define-struct CD (artist title price))
(define-struct sweater (material size producer))
