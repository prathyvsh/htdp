#lang racket
(require lang/htdp-advanced)

;; A building is
;; (make-building symbol symbol (listof symbol))
(define-struct building (name picture connections))

;; A campus is
;;(listof building)

;; SAMPLE DATA

(define rice
  (list (make-building 'MuddBuilding 'Mudd (list 'EngineeringQ 'Bio-Engineers))
        (make-building 'Bio-Engineers 'Bio (list 'MuddBuilding))
        (make-building 'EngineeringQ 'Eng (list 'MuddBuilding))))
