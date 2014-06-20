(define-struct fighter (designation acceleration top-speed range))

;; within-range fighter number -> boolean
;; Calculates if the target-range is within fighter's range
(define (within-range fighter target-range)
  (<= target-range (fighter-range fighter)))

;; reduce-range fighter -> fighter
;; Creates a fighter with range reduced by 80%
(define (reduce-range fighter)
  (make-fighter (fighter-designation fighter)
                (fighter-acceleration fighter)
                (fighter-top-speed fighter)
                (* 0.80 (fighter-range fighter))
                ))


;; TESTS
(define fighter1 (make-fighter 'f22 300 20 50))
(define fighter2 (make-fighter 'tornado 400 30 100))
(define fighter3 (make-fighter 'mig22 500 40 25))

(within-range fighter1 20) "should be" true
(within-range fighter1 300) "should be" false
(within-range fighter1 10) "should be" true

(= (fighter-range (reduce-range fighter1)) 40)
(= (fighter-range (reduce-range fighter2)) 80)
(= (fighter-range (reduce-range fighter3)) 20)
