;; height : number number -> number
;; Calculates the height reached by a rocket when it accelerates at a
;; constant rate g
(define (rocket-height g time)
  (* 0.5 (rocket-speed g time) time))

(define (rocket-speed g time)
  (* g time))


;; COMPUTATION
(rocket-height 10 10)
