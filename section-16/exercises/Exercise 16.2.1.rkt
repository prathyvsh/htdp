#lang racket
(require lang/htdp-beginner)

;; A file is a symbol
;; A directory is either
;; 1. empty
;; 2. (cons f d) where f is a file and d is a dir; or
;; 3. (cons d1 d2) where d1 and d2 are dirs

(define docs (list 'read!))
(define code (list 'hang 'draw))
(define libs (list code docs))
(define text (list 'part1 'part2 'part3))
(define ts (list 'read! text libs))
