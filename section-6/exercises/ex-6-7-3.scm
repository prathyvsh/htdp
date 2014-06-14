(define TOP-OFFSET 10)
(define PLANK-HORIZONTAL-WIDTH 100)
(define NOOSE-VERTICAL-HEIGHT 30)
(define HEAD-RADIUS 10)
(define BODY-HEIGHT 50)
(define ARM-LENGTH 60)
(define ARM-SLANT 10)
(define LEG-SLANT 30)

(define plank-start (make-posn 0 TOP-OFFSET))
(define plank-end (make-posn (+ (posn-x plank-start) PLANK-HORIZONTAL-WIDTH) (posn-y plank-start)))
(define head-location (make-posn (posn-x plank-end) (+ (posn-y plank-end) NOOSE-VERTICAL-HEIGHT HEAD-RADIUS)))
(define body-start (make-posn (posn-x head-location) (+ (posn-y head-location) HEAD-RADIUS)))
(define body-end (make-posn (posn-x body-start) (+ (posn-y body-start) BODY-HEIGHT)))
(define arm-start (make-posn PLANK-HORIZONTAL-WIDTH (+ NOOSE-VERTICAL-HEIGHT HEAD-RADIUS (* 2/3 BODY-HEIGHT))))
(define left-arm-end (make-posn (+ ARM-LENGTH (posn-x arm-start)) (- (posn-y arm-start) ARM-SLANT)))
(define right-arm-end (make-posn (- (posn-x arm-start) ARM-LENGTH) (posn-y left-arm-end)))
(define leg-start (make-posn PLANK-HORIZONTAL-WIDTH (+ TOP-OFFSET NOOSE-VERTICAL-HEIGHT (* 2 HEAD-RADIUS) BODY-HEIGHT)))
(define left-leg-end (make-posn (+ ARM-LENGTH (posn-x arm-start)) (+ (posn-y leg-start) LEG-SLANT)))
(define right-leg-end (make-posn (- (posn-x arm-start) ARM-LENGTH) (posn-y left-leg-end)))

;; circle is a structure
;; make-circle position number symbol
(define-struct circle (center radius color))

;; draw-a-circle : circle -> true
;; Draws a give circle on screen
(define (draw-a-circle c)
  (draw-circle (circle-center c) (circle-radius c) (circle-color c)))

;; draw-plank : position position -> true
;; Draws a horizontal plank from start to end
(define (draw-plank start end)
  (draw-solid-line start end 'black))
;; draw-noose : position position -> true
;; Draws a noose from start to end
(define (draw-noose start end)
  (and (draw-plank start end)
       (draw-solid-line end (make-posn (posn-x end) (+ (posn-y start) NOOSE-VERTICAL-HEIGHT)) 'black)))

;; draw-head : position -> true
;; Draws a circular head at the given location
(define (draw-head location)
  (draw-a-circle (make-circle location HEAD-RADIUS 'black)))

;; draw-body : position position -> true
;; Draws body from start to end
(define (draw-body start end)
  (draw-solid-line start end 'black))

;; draw-limb : position position -> true
;; Draws a limb from start to end
(define (draw-limb start end) 
  (draw-solid-line start end 'black))

;; draw-next-part : symbol -> true
;; Takes in a symbol and draws the corresponding part
(define (draw-next-part organ) 
  (cond
  [(symbol=? organ 'noose) (draw-noose plank-start plank-end)]
  [(symbol=? organ 'head) (draw-head head-location)]
  [(symbol=? organ 'body) (draw-body body-start body-end)]
  [(symbol=? organ 'left-arm) (draw-limb arm-start left-arm-end)]
  [(symbol=? organ 'right-arm) (draw-limb arm-start right-arm-end)]
  [(symbol=? organ 'left-leg) (draw-limb leg-start left-leg-end)]
  [(symbol=? organ 'right-leg) (draw-limb leg-start right-leg-end)]
  ))
;; word3 is a structure:
;; (make-word3 number number number)
(define-struct word (first second third))

;; TEMPLATE
;(define (reveal chosen status guess)
;... (word-first chosen) ... (word-first status) ...
;... (word-second chosen) ... (word-second status) ...
;... (word-third chosen) ... (word-third status) ...)

;; First Approach (Failed)
(define (reveal-first chosen status guess)
  (cond
    [(symbol=? (word-first chosen) guess) (make-word guess (word-second status) (word-third status))]
    [(symbol=? (word-second chosen) guess) (make-word (word-first status) guess (word-third status))]
    [(symbol=? (word-third chosen) guess) (make-word (word-first status) (word-third status) guess)]
    [else status]))

;; compare-letter symbol symbol symbol -> symbol
;; Return the guess if it is same as chosen otherwise, returns status
(define (compare-letter chosen status guess)
  (cond
  [(symbol=? chosen guess) guess]
  [else status]))

;; Second Approach
;; reveal symbol symbol symbol -> symbol
;; Returns a word with correctly guessed characters in chosen word
(define (reveal chosen status guess)
  (make-word (compare-letter (word-first chosen) (word-first status) guess)
             (compare-letter (word-second chosen) (word-second status) guess)
             (compare-letter (word-third chosen) (word-third status) guess)))

;; TESTS
;(reveal (make-word 't 'e 'a) (make-word '_ 'e '_) 'u)
;(reveal (make-word 'a 'l 'e) (make-word 'a '_ '_) 'e)
;(reveal (make-word 'a 'l 'l) (make-word '_ '_ '_) 'l)

;; PROGRAM
(start 300 300)
(hangman make-word reveal draw-next-part)
