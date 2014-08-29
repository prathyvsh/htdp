#lang racket
(require lang/htdp-intermediate-lambda)

(define JANUS
  (list #i31
        #i2e+34
        #i-1.2345678901235e+80
        #i2749
        #i-2939234
        #i-2e+33
        #i3.2e+270
        #i17
        #i-2.4e+270
        #i4.2344294738446e+170
        #i1
        #i-8e+269
        #i0
        #i99))

(define (sum lst)
(foldl + 0 lst))

(sum JANUS)
(sum (reverse JANUS))

;; The differences arises from the fact the when
;; adding from left to right, numbers are approximated
;; to the precision of the greatest precise number
;; encountered in the list. When summing from the left,
;; the numbers with greatest precision are
;; #i3.2e+270 and #i-2.4e+270, sum of which is
;; #i8e+269. On continuing, they cancel out with #i-8e+269
;; leaving #i0 + #i99 = #i99 as the answer.
;; Whereas when summing up from right, this cancellation
;; leaves, numbers :
;; #i31 #i2e+34 #i-1.2345678901235e+80 #i2749 #i-2939234 #i-2e+33
;; to sum up among which #i-1.2345678901235e+80 has the most precision
;; and is returned as the answer.

;; Can we trust computers?
;; As far as we can trust ourselves to program them right.
