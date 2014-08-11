#|

Evaluation 1:
(f l) is never evaluated
(f m) is evaluated once
(f r) is evaluated once


There are two cases now:

If:
(cond
 [(<= (f m) 0 (f r)) (find-root m r)]
 [else (find-root l m)])

evaluates to true,

Evaluation 2:
(find-root m r) which gives new mid as

(m + r)/2, let this be q. Now, the next
evaluation is:

(cond
 [(<= (f q) 0 (f r)) (find-root q r)]
 [else (find-root l q)])

In this execution:
(f m) is never evaluated
(f r) is evaluated once
(f q) is evaluated twice

We can notice that the case has now,
lost the variable m present in it.

Hence it can be seen it total that
(f l) was never evaluated
(f m) was evaluated once
(f r) was evaluated twice

(f r) holds chance for more executions since
the evaluative steps in the condition statement
is always of (f mid) and (f right). Similar conditions
arise if the condition evaluated to false in Case 1.
There, (f m) holds chance for more evaluations since
it can always be on the right.

This means that the the auxiliary function requires
only a right hand element to be passed in. Modifications
have been done accordingly.



#lang racket
(define (find-root f left right)
  (local ((define (find-root-aux f left right f-right)
            (cond
             [(<= (- right left) TOLERANCE) left]
             [else 
              (local ((define mid (/ (+ left right) 2)))
                (cond
                 [(<= (f mid) 0 f-right)
                  (find-root-aux f mid right f-right)]
                 [else 
                  (find-root-aux f left mid (f mid))]))])))
    (find-root-aux f left right (f right))
    ))

;; original-find-root : (number  ->  number) number number  ->  number
;; to determine a number R such that f has a 
;; root between R and (+ R TOLERANCE) 
;; 
;; ASSUMPTION: f is continuous and monotonic
(define (original-find-root f left right)
  (cond
   [(<= (- right left) TOLERANCE) left]
   [else 
    (local ((define mid (/ (+ left right) 2)))
      (cond
       [(<= (f mid) 0 (f right)) 
        (find-root f mid right)]
       [else 
        (find-root f left mid)]))]))

;; TESTS
(define (poly x)
  (* (- x 2) (- x 4)))

(define TOLERANCE (expt 10 -1000))

(define l -2000)
(define r 3)

(collect-garbage)
(time (original-find-root poly l r))

(collect-garbage)
(time (find-root poly l r))


|#

#lang racket

;; But this fails to produce any compelling results where as
;; modifying the equation prior to Figure 75 yields expected
;; results:

;; find-root : (number  ->  number) number number  ->  number
;; to determine a number R such that f has a 
;; root between R and (+ R TOLERANCE) 
;; 
;; ASSUMPTION: f is continuous and monotonic
(define (find-root f left right)
  (cond
   [(<= (- right left) TOLERANCE) left]
   [else 
    (local ((define mid (/ (+ left right) 2)))
      (cond
       [(or (<= (f left) 0 (f mid)) (<= (f mid) 0 (f left)))
        (find-root f left mid)]
       [(or (<= (f mid) 0 (f right)) (<= (f right) 0 (f mid))) (find-root f mid right)]))]))


(define (find-root-mod f left right)
  (local ((define (find-root-aux f left right f-left f-right)
            (cond
             [(<= (- right left) TOLERANCE) left]
             [else (local ((define mid (/ (+ left right) 2))
                           (define f-mid (f mid)))
                     (cond
                      [(or (<= f-left 0 f-mid) (<= f-mid 0 f-left))
                       (find-root-aux f left mid f-left f-mid)]
                      [(or (<= f-mid 0 f-right) (<= f-right 0 f-mid))
                       (find-root-aux f mid right f-mid f-right)]))])))
    (find-root-aux f left right (f left) (f right))))


;; TESTS
(define (poly x)
  (* (- x 2) (- x 4)))

(define TOLERANCE (expt 10 -1000))

(define l 3)
(define r -200)

(collect-garbage)
(time (find-root-mod poly 3 1000))
(collect-garbage)
(time (find-root poly 3 1000))
