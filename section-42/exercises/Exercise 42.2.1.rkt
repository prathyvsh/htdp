;; HAND EVALUATIONS

#|

(eq-posn (make-posn 1 2) (make-posn 1 2))

(define p1 (make-posn 1 2))
(define p2 (make-posn 1 2))
(define old-x1 1)
(define old-x2 2)
;; modify both x fields of p1 and p2
(define effect1 (set-posn-x! p1 5))
(define effect2 (set-posn-x! p2 6))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p1 (make-posn 5 2))
(define p2 (make-posn 6 2))
(define old-x1 1)
(define old-x2 2)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p1 (make-posn 5 2))
(define p2 (make-posn 6 2))
(define old-x1 1)
(define old-x2 2)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same (= 5 6))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2)))
same

;;

(define p1 (make-posn 5 2))
(define p2 (make-posn 6 2))
(define old-x1 1)
(define old-x2 2)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same false)
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;
(define p1 (make-posn 1 2))
(define p2 (make-posn 1 2))
false

|#



(local ((define p (make-posn 1 2)))
  (eq-posn p p))

;;

(define p (make-posn 1 2))
(define p1 p)
(define p2 p)
(define old-x1 (posn-x p))
(define old-x2 (posn-x p))
;; modify both x fields of p1 and p2
(define effect1 (set-posn-x! p1 5))
(define effect2 (set-posn-x! p2 6))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 1 2))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (set-posn-x! p1 5))
(define effect2 (set-posn-x! p2 6))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 6 2))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 6 2))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same (= 6 6))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 6 2))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same true)
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 1 2))
(define p1 p)
(define p2 p))
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same true)
;; restore old values
(define effect3 (void))
(define effect4 (void))
same

;;

(define p (make-posn 1 2))
true

|#

(local ((define p (make-posn 1 2))
        (define a (list p)))
  (eq-posn (first a) p))

;;

(define p (make-posn 1 2))
(define a (list p))
(define p1 p)
(define p2 p)
(define old-x1 (posn-x p1))
(define old-x2 (posn-x p2))
;; modify both x fields of p1 and p2
(define effect1 (set-posn-x! p1 5))
(define effect2 (set-posn-x! p2 6))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 1 2))
(define a (list p))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (set-posn-x! p1 5))
(define effect2 (set-posn-x! p2 6))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 6 2))
(define a (list p))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same (= (posn-x p1) (posn-x p2)))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 6 2))
(define a (list p))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same (= 6 6))
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 6 2))
(define a (list p))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same true)
;; restore old values
(define effect3 (set-posn-x! p1 old-x1))
(define effect4 (set-posn-x! p2 old-x2))
same

;;

(define p (make-posn 1 2))
(define a (list p))
(define p1 p)
(define p2 p)
(define old-x1 1)
(define old-x2 1)
;; modify both x fields of p1 and p2
(define effect1 (void))
(define effect2 (void))
;; now compare the two fields
(define same true)
;; restore old values
(define effect3 (void))
(define effect4 (void))
same

;;

(define p (make-posn 1 2))
(define a (list p))
true
