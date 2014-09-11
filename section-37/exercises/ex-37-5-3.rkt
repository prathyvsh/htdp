#lang racket
(require lang/htdp-advanced)

;; A building is
;; (make-building symbol symbol symbol (listof symbol))
(define-struct building (name picture object connections))

;; A campus is
;;(listof building)

;; SAMPLE DATA

(define CAMPUS
  (list (make-building 'MuddBuilding 'Mudd 'Sandbox (list 'EngineeringQ 'Bio-Engineers))
        (make-building 'Bio-Engineers 'Bio 'Pitcher (list 'MuddBuilding))
        (make-building 'EngineeringQ 'Eng 'Anchor (list 'MuddBuilding))))

(define BAG-SIZE 2)

;; STATE VARIABLES

;; location : symbol
;; Indicates the current location
(define location empty)

;; bag : symbol
;; Inventory at hand
(define bag empty)

;; show-me -> symbol
;; Displays the picture of current location
(define (show-me) (building-name (current-building)))

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

;; current-building -> building
;; Gives the current building player is located at
(define (current-building)
  (find-building location))

;; go : building -> void
;; Moves the current location of the player
(define (go name)
  (if (memq name (where-to-go)) (set! location name) (error 'go "No such location exists")))

;; init-game -> void
;; Starts the game
(define (init-game)
  (begin (set! location (building-name (first CAMPUS)))
         (set! bag empty)))

;; pick-object -> void
;; Fills the bag with the picked up objets.
;; Once the bag is full, the last item is
;; swapped.
(define (pick-object)
  (cond
   [(empty? (building-object (current-building))) (void)]
   [(= (length bag) BAG-SIZE) (local ((define temp (first bag)))
                                (begin (set! bag (cons (building-object (current-building)) (rest bag))) (set! CAMPUS (replace-obj temp))))]
   [else (begin
           (set! bag (cons (building-object (current-building)) bag))
           (set! CAMPUS (replace-obj empty)))]))

;; replace-obj : symbol
(define (replace-obj obj)
  (map (lambda (x)
         (cond
          [(symbol=? location (building-name x)) (make-building (building-name x)
                                                                (building-picture x)
                                                                obj
                                                                (building-connections x))]
          [else x])) CAMPUS))

(init-game)
(go (first (where-to-go)))
(equal? location 'EngineeringQ)
(pick-object)
(and (equal? bag (list 'Anchor))
     (equal? (building-object (current-building)) empty))
(go 'MuddBuilding)
(pick-object)
(go 'Bio-Engineers)
(pick-object)
(and (equal? bag (list 'Pitcher 'Anchor))
     (equal? (building-object (current-building)) 'Sandbox))
