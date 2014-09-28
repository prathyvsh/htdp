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

;; increase-percentage : PR number
(define (increase-percentage a-pr percentage)
  (cond
   [(<= 3 percentage 7)
  (local ((define salary (personnel-salary a-pr))
          (define raise (* (/ percentage 100) salary))
          (define result (min raise 7000)))
    (increase-salary a-pr result))]
   [else (error 'increase-percentage "Please provide a value between 3% and 7%")]))

;; TESTS
(define mitch (make-personnel 'Mitchell '85Tera 160000))
(define abraham (make-personnel 'Abraham '92Meridian 60000))

(increase-percentage mitch 5)
(equal? mitch (make-personnel 'Mitchell '85Tera 167000))
(increase-percentage abraham 5)
(equal? abraham (make-personnel 'Abraham '92Meridian 63000))


