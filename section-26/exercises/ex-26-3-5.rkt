#|
;; HAND EVALUATION

(quick-sort (list 10 6 8 9 14 12 3 11 14 16 2))

;; Append : 1 QS : 2
(append (quick-sort (list 6 8 9 3 2))
        (list 10)
        (quick-sort (list 14 12 11 14 16)))

;; Append : 2 QS : 4
(append (append (quick-sort (list 3 2))
                (list 6)
                (quick-sort (list 8 9)))
        (list 10)
        (quick-sort (list 14 12 11 14 16)))

;; Append : 3 QS : 6
(append (append (append (quick-sort (list 2))
                        (list 3)
                        (quick-sort empty))
                (list 6)
                (quick-sort (list 8 9)))
        (list 10)
        (quick-sort (list 14 12 11 14 16))))

;; Append : 4 QS : 8
(append (append (list 2 3)
                (list 6)
                (append (quick-sort empty)
                        (list 8)
                        (quick-sort (list 9))))
        (list 10)
        (quick-sort (list 14 12 11 14 16)))

;; Append : 4 QS : 8
(append (list 2 3 6 8 9)
        (list 10)
        (quick-sort (list 14 12 11 14 16)))

;; Append : 5 QS : 10
(append (list 2 3 6 8 9)
        (list 10)
        (append (quick-sort (list 11 12))
                (list 14)
                (quick-sort (list 14 16))))

;; Append : 6 QS : 12
(append (list 2 3 6 8 9)
        (list 10)
        (append (append (quick-sort (list 11))
                        (list 12)
                        (quick-sort empty))
                (list 14)
                (quick-sort (list 14 16))))

;; Append : 7 QS : 14
(append (list 2 3 6 8 9)
        (list 10)
        (append (list 11 12)
                (list 14)
                (append (quick-sort empty)
                        (list 14)
                        (quick-sort (list 16))))))

;; Append : 7 QS : 14
(list 2 3 6 8 9 10 11 12 14 14 16)

;; 14 calls to quick-sort and 7 calls to append
|#


#|
;; GENERAL RULE

Recursive append and qs calls for n elements with
equal distribution of higher and lower elements

A. 1 element - 0 Append 0 QS

B. 2 elements - 1 Append 2 QS

C. 3 elements
(qs 5 4 3) yields (append (qs 3) (list 4) (qs 5))
1 + A. + A. = 1 + 0 + 0 Append Calls

D. 4 elements
(qs 4 5 3 2) yields (append (qs 5) (list 4) (qs 3 2))
yields qs of 1 element and qs of 2 elements
1 + A. + B. = 1 + 0 + 1 Append Calls
2 Append which yields 4 QS

E. 5 elements
(qs 3 1 5 4 2) yields (append (qs 1 2) (list 4) (qs 5 4))
1 + B. + B. = 1 + 1 + 1 Append Calls
3 Append which yields 6 QS

6 elements
(qs 3 1 5 6 4 2) yields (append (qs 1 2) (list 3) (list 4 5 6))
1 + B. + C.  = 1 + 1 + 1 Append Calls
3 Append which yields 6 QS

This suggests for 11 elements with equal distributions there would be
1 + (Append calls of (11-1)/2 elements) + (Append calls of (11+1)/2 elements)
1 + (Append Calls of E.) + (Append calls of F.)
1 + 3 + 3 Append Calls = 7 Append Calls
which yields 14 QS and this matches the observation


Let AC(n) denote append calls for a list of n elements (n > 1)
then it can be said that:
AC(0) = 1
AC(1) = 1
AC(n) = 1 + AC((n - 1)/2) + AC((n + 1)/2)

and if QSC(n) denotes quick sort calls for list of n elements
QSC(n) = AC(n) * 2

#|

|#

(quick-sort (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))

;; Append : 1 QS : 2
(append (quick-sort empty)
        (list 1)
        (quick-sort (list 2 3 4 5 6 7 8 9 10 11 12 13 14)))

;; Append : 2 QS : 4
(append empty (list 1)
        (append (quick-sort empty)
                (list 2)
                (quick-sort (list 3 4 5 6 7 8 9 10 11 12 13 14))))

;; Append : 3 QS : 6
(append empty (list 1)
        (append empty (list 2)
                (append (quick-sort empty)
                        (list 3)
                        (quick-sort (list 4 5 6 7 8 9 10 11 12 13 14)))))

;; Append : 4 QS : 8
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append (quick-sort empty)
                                (list 4)
                                (quick-sort (list 5 6 7 8 9 10 11 12 13 14))))))

;; Append : 5 QS : 10
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append (quick-sort empty)
                                        (list 5)
                                        (quick-sort (list 6 7 8 9 10 11 12 13 14)))))))


;; Append : 6 QS : 12
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (quick-sort (list 6 7 8 9 10 11 12 13 14)))))))

;; Append : 7 QS : 14
(append empty
        (list 1)
        (append empty
                (list 2)
                (append empty
                        (list 3)
                        (append empty
                                (list 4)
                                (append empty
                                        (list 5)
                                        (append (quick-sort empty)
                                                (list 6)
                                                (quick-sort (list 7 8 9 10 11 12 13 14))))))))

;; Append : 8 QS : 16
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (append empty (list 6)
                                                (append (quick-sort empty)
                                                        (list 7)
                                                        (quick-sort (list 8 9 10 11 12 13 14)))))))))

;; Append : 9 QS : 18
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (append empty (list 6)
                                                (append empty (list 7)
                                                        (append (quick-sort empty)
                                                                (list 8)
                                                                (quick-sort (list 9 10 11 12 13 14))))))))))


;; Append : 10 QS : 20
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (append empty (list 6)
                                                (append empty (list 7)
                                                        (append empty (list 8)
                                                                (append (quick-sort empty)
                                                                        (list 9)
                                                                        (quick-sort (list 10 11 12 13 14)))))))))))

;; Append : 11 QS : 22
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (append empty (list 6)
                                                (append empty (list 7)
                                                        (append empty (list 8)
                                                                (append empty (list 9)
                                                                        (append (quick-sort empty)
                                                                                (list 10)
                                                                                (quick-sort (list 11 12 13 14))))))))))))
;; Append : 12 QS : 24
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (append empty (list 6)
                                                (append empty (list 7)
                                                        (append empty (list 8)
                                                                (append empty (list 9)
                                                                        (append empty (list 10)
                                                                                (append (quick-sort empty)
                                                                                        (list 11)
                                                                                        (quick-sort (list 12 13 14)))))))))))))

;; Append : 13 QS : 26
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (append empty (list 6)
                                                (append empty (list 7)
                                                        (append empty (list 8)
                                                                (append empty (list 9)
                                                                        (append empty (list 10)
                                                                                (append empty (list 11)
                                                                                        (append (quick-sort empty)
                                                                                                (list 12)
                                                                                                (quick-sort (list 13 14))))))))))))))

;; Append : 14 QS : 28
(append empty (list 1)
        (append empty (list 2)
                (append empty (list 3)
                        (append empty (list 4)
                                (append empty (list 5)
                                        (append empty (list 6)
                                                (append empty (list 7)
                                                        (append empty (list 8)
                                                                (append empty (list 9)
                                                                        (append empty (list 10)
                                                                                (append empty (list 11)
                                                                                        (append empty (list 12)
                                                                                                (append (quick-sort empty)
                                                                                                        (list 13)
                                                                                                        (quick-sort (list 14)))))))))))))))

(list 1 2 3 4 5 6 7 8 9 10 11 12 13 14)
14 append calls and 28 quick-sort calls

Yes it contradicts the first part results because here the distribution on the
subsequent quick sort call is skewed with one side having 0 elements and other side
having n-1 elements.

Here,
ASC(0) = 0
ASC(1) = 1
ASC(n) = 1 + ASC(n-1)

QSC(n) = ASC(n) * 2;

Hence for n = 14
ASC(n) = 14
QC(n) = 28
|#

