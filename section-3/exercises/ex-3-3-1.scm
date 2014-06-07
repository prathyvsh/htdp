;; CONSTANTS
(define cm-per-inch 2.54)
(define inches-per-foot 12)
(define feet-per-yard 3)
(define yards-per-rod (+ 5 1/2))
(define rods-per-furlong 40)
(define furlongs-per-mile 8)

;; inches->cm : number -> number
;; Converts inches to centimeters
(define (inches->cm inches)
  (* inches cm-per-inch))

;; feet->inches : number -> number
;; Converts feet to inches
(define (feet->inches feet)
  (* feet inches-per-foot))

;; yards->feet : number -> number
;; Converts yards to feet
(define (yards->feet yards)
  (* yards feet-per-yard))

;; rods->yards : number -> number
;; Converts rods to yards
(define (rods->yards rods)
  (* rods yards-per-rod))

;; furlongs->rods : number -> number
;; Converts furlongs to rods
(define (furlongs->rods furlongs)
  (* furlongs rods-per-furlong))

;; miles->furlongs : number -> number
;; Converts miles to furlongs
(define (miles->furlongs miles)
  (* miles furlongs-per-mile))

;; feet->cm : number -> number
;; Converts feet to centimeters
(define (feet->cm feet)
  (inches->cm
    (feet->inches feet)))

;; yards->cm : number -> number
;; Converts yards to centimeters
(define (yards->cm yards)
  (feet->cm
    (yards->feet yards)))


;; rods->inches : number -> number
;; Converts rods to inches
(define (rods->inches rods)
  (feet->inches
    (yards->feet
      (rods->yards rods))))

;; miles->feet : number -> number
;; Converts miles to feet
(define (miles->feet miles)
  (yards->feet
    (rods->yards
      (furlongs->rods
        (miles->furlongs miles)))))

;; TESTS
(miles->feet 20)
(rods->inches 35)
(yards->cm 25)
(feet->cm 30)
