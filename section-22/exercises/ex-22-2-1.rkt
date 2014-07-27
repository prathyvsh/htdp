#lang racket
(require lang/htdp-intermediate)

;; DATA-DEFINITIONS
(define-struct IR (name price))

;; build-map : (X -> Y) -> ((listof X) -> (listof Y))
;; Builds a map of given function
(define (build-map fn)
  (local ((define (map1 alon)
          (cond
           [(empty? alon) empty]
           [else
            (cons (fn (first alon))
                  (map1 (rest alon)))]))) map1))


;; fahrenheit->celsius : number -> number
;; Converts fahrenheit to celsius
(define (fahrenheit->celsius fht)
  (* (/ 5 9) (- fht 32)))

(define fc-map (build-map fahrenheit->celsius))
(define name-map (build-map IR-name))

;; convertFC : (listof number) -> (listof number)
;; Converts a list of farenheit temperatures to celsius
(define (convertFC alon) (fc-map alon))

;; names : loIR  ->  los
;; Collects the list of names from the list of IRs
(define (names aloIR) (name-map aloIR))

;;TESTS
(equal? (convertFC (list -40 32 212)) (list -40 0 100))
(equal? (names (list (make-IR 'Doll 1.99) (make-IR 'Map 2.99))) (list 'Doll 'Map))



                      
