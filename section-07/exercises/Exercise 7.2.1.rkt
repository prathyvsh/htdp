#lang racket
(require lang/htdp-beginner)

;; A zoo-animal is either:
;; (make-spider number number)
;; (make-elephants number)
;; (make-monkey symbol number)
(define-struct spiders (legs space))

(define-struct elephants (space))

(define-struct monkeys (intelligence space))


;; TEMPLATE
(define (zoo-animal-manipulations animal)
  (cond
    [(spiders? animal)
     ... (spiders-legs animal) ... (spiders-space animal) ...]
    [(elephants? animal)
     ... (elephants-space animal) ...]
    [(monkeys? animal)
     ... (monkeys-intelligence animal) ... (monkeys-space animal) ...]
    ))


;; fits? animal number -> boolean
;; Determines if the animal fits into the given cage-volume
(define (fits? animal cage-volume)
  (cond
    [(spiders? animal) (< (spiders-space animal) cage-volume)]
    [(elephants? animal) (< (elephants-space animal) cage-volume)]
    [(monkeys? animal) (< (monkeys-space animal) cage-volume)]
    ))
