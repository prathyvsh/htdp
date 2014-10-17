#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
;; An inventory record consists of
;; (make-struct ir1 (symbol number))
(define-struct ir1 (name price))

;; inventory1 is either
;; empty or
;; (cons ir1 inventory1) where ir1 is an inventory record.

;; No, the refined contract does not affect development of the function
