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
  (local ((define salary (personnel-salary a-pr))
          (define low (* 0.03 salary))
          (define high (* 0.07 salary)))
    (cond
     [(<= low a-raise high)
  (set-personnel-salary! a-pr (+ (personnel-salary a-pr) a-raise))]
     [else (error 'increase-salary "Please provide a raise between 3% and 7%")])))

;; TESTS
(define george (make-personnel 'George '45Enclave 38000))
(define ram (make-personnel 'Ram '89Ave 36000))

(increase-salary george 2000)
(equal? (personnel-salary george) 40000)
(increase-salary ram 1800)
;(increase-salary george 1080)
(equal? (personnel-salary ram) 37800)
