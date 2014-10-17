#lang racket
(require lang/htdp-beginner)

;; DATA DEFINITION
(define-struct ir (name price image))
;; an inventory record is
;; (make-ir symbol number picture)

;; SAMPLE REPRESENTATIONS
(define current-inventory
  (cons (make-ir 'classic 29.95 'robot-image-1)
        (cons (make-ir 'humanoid 29.95 'robot-image-2)
              (cons (make-ir 'transport 29.95 'robot-image-3) empty))))

;; show-picture : symbol inventory -> an image or false
(define (show-picture toy-name inv)
  (cond
    [(empty? inv) false]
    [else (cond
            [(symbol=? (ir-name (first inv)) toy-name)
             (ir-image (first inv))]
            [else (show-picture toy-name (rest inv))])]))

;; TESTS
(symbol=? (show-picture 'classic current-inventory) 'robot-image-1)
(symbol=? (show-picture 'humanoid current-inventory) 'robot-image-2)
(symbol=? (show-picture 'transport current-inventory) 'robot-image-3)
