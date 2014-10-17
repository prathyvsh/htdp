#lang racket
(require lang/htdp-advanced)

;; A building is
;; (make-building symbol symbol (listof symbol))
(define-struct building (name picture connections))

;; A campus is
;;(listof building)

;; SAMPLE DATA

(define CAMPUS
  (list (make-building 'MuddBuilding 'Mudd (list 'EngineeringQ 'Bio-Engineers))
        (make-building 'Bio-Engineers 'Bio (list 'MuddBuilding))
        (make-building 'EngineeringQ 'Eng (list 'MuddBuilding))))

;; STATE VARIABLES

;; location : symbol
;; Indicates the current location
(define location empty)

;; show-me -> symbol
;; Displays the picture of current location
(define (show-me) (building-name location))

;; where-to-go -> (listof symbol)
;; Gives a list of connected buildings
(define (where-to-go)
  (building-connections (find-building location)))

;; find-building : symbol
(define (find-building name)
  (foldr (lambda (x y)
           (cond
            [(symbol=? name (building-name x)) x]
            [else y])) empty CAMPUS))

;; go : building -> void
;; Moves the current location of the player
(define (go name)
  (if (memq name (where-to-go)) (set! location name) (error 'go "No such location exists")))

;; init-game -> void
;; Starts the game
(define (init-game)
  (set! location (building-name (first CAMPUS))))

(init-game)
(go (first (where-to-go)))
(equal? location 'EngineeringQ)
