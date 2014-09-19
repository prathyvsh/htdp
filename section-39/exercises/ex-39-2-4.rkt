#lang racket
(require lang/htdp-advanced)

;; make-player : symbol -> service-manager
;; Creates a new maze game
(define (make-player start)
  (local (
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

;; message -> symbol
;; Last message sent to the player
(define message empty)

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

;; talk -> symbol
;; Effect : Sets the message variable to msg
(define (talk msg) (set! message msg))

;; send-msg : sym -> void
;; Send message to a player
(define (send-msg player msg) ((player 'talk) msg))

;; service-manager : symbol -> service
;; Service manager for the maze game
(define (service-manager sym)
  (cond
   [(symbol=? sym 'current) (show-me)]
   [(symbol=? sym 'connections) (where-to-go)]
   [(symbol=? sym 'move) go]
   [(symbol=? sym 'pick) (pick-object)]
   [(symbol=? sym 'bag) bag]
   [(symbol=? sym 'talk) talk]
   [(symbol=? sym 'send) send-msg]
   [(symbol=? sym 'last-msg) message]
   [else (error 'service-manager "Unknown symbol")])))
    
(begin (init-game) service-manager)))

(define player1 (make-player 'BioEngineering))
(define player2 (make-player 'MuddBuilding))

((player1 'move) (first (player1 'connections)))
(equal? (player1 'current) 'EngineeringQ)
(player1 'pick)
(equal? (player1 'bag) (list 'Anchor))
((player1 'move) 'MuddBuilding)
(player1 'pick)
((player1 'move) 'Bio-Engineers)
(player1 'pick)
(equal? (player1 'bag) (list 'Pitcher 'Anchor))
((player2 'send) player1 'hello)
((player1 'send) player2 'hi)
(equal? (player1 'last-msg) 'hello)
(equal? (player2 'last-msg) 'hi)
