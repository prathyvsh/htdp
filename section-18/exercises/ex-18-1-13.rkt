#lang racket
(require lang/htdp-intermediate)

#|
;; DATA DEFINITION
A child node is (make-child child child symbol number symbol)
|#
(define-struct child (father mother name date eye-color))

#|
A direction is either
1. the symbol 'father or
2. the symbol 'mother.

A path is either
1. empty or
2. (cons s los) where s is a direction and los is a path.
|#

#|
TEMPLATE
(define ftn-func (child)
  (cond
   [(empty? child) ...]
   [else ... (ftn-func (child-father child)) ...
         ... (ftn-func (child-mother child)) ...
         ... (child-name child) ... (child-date child)
         ... (child-eye-color child)]))

|#
;; to-blue-eyed-ancestor : ftn -> path or false
;; To compute the path from a-ftn tree to a blue-eyed ancestor
(define (to-blue-eyed-ancestor child)
  (cond
   [(empty? child) false]
   [(symbol=? (child-eye-color child) 'blue) empty]
   [else (local ((define f (to-blue-eyed-ancestor (child-father child))))
                 (cond [(false? f)
                        (local ((define m (to-blue-eyed-ancestor (child-mother child))))
                                      (cond
                                       [(false? m) false]
                                       [else (cons 'mother m)]))]
                  [else (cons 'father f)]))]))



;; DATA SAMPLES
;; First Generation:
(define Carl (make-child empty empty 'Carl 1926 'green))
(define Bettina (make-child empty empty 'Bettina 1926 'green))

;; Second Generation:
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Third Generation: 
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))

;; Last Generation:
(define Hal (make-child Gustav Eva 'Gustav 1988 'hazel))

;; TESTS
(equal? (to-blue-eyed-ancestor Gustav) (list 'mother))
(equal? (to-blue-eyed-ancestor Eva) empty)
(equal? (to-blue-eyed-ancestor Carl) false)
(equal? (to-blue-eyed-ancestor Dave) false)
(equal? (to-blue-eyed-ancestor Hal) (list 'father 'mother))
