#lang racket
(require lang/htdp-advanced)

;; A personnel record (PR) is a structure: 
;; (make-personnel n a s)
;; where n is a symbol, a is a string, and s is a number. 
(define-struct personnel (name address salary))

#|
;; TEMPLATE
(define (fun-for-personnel pr)
  ... (personnel-name pr) ...
  ... (personnel-address pr) ...
  ... (personnel-salary pr) ...)  
|#

;; increase-salary : PR number  ->  void
;; effect: to modify the salary field of a-pr by adding in a-raise
(define (increase-salary a-pr a-raise)
  (set-personnel-salary! a-pr (+ (personnel-salary a-pr) a-raise)))

;; TESTS
(define ram (make-personnel 'Ram '89Ave 38000))
(define george (make-personnel 'George '45Enclave 36000))

(increase-salary ram 7000)
(equal? (personnel-salary ram) 45000)
(increase-salary george 5000)
(increase-salary ram 2000)
(equal? (personnel-salary george) 41000)
(equal? (personnel-salary ram) 47000)
