#lang racket
(require lang/htdp-advanced)

(define-struct cheerleader (name dates))
;; A cheerleader is a structure: 
;; (make-cheerleader n d)
;; where n is a symbol and d is a list of symbols. 

;; new-date : cheerleader symbol -> (void)
(define (new-date cl date)
  (set-cheerleader-dates! cl (cons date (cheerleader-dates cl))))

;; TESTS
(define tiffany (make-cheerleader 'tiffany (list 'Mark)))
(new-date tiffany 'Antony)
(equal? tiffany (make-cheerleader 'tiffany (list 'Antony 'Mark)))

