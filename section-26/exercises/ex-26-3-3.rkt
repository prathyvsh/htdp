#|
;; TIMING

(time (gcd-generative 101135853 45014640))
cpu time: 0 real time: 0 gc time: 0

;; HAND EVALUATION

(clever-gcd 101135853 45014640)
= (clever-gcd 45014640 11106573)
= (clever-gcd 45014640 11106573)
= (clever-gcd 11106573 588348)
= (clever-gcd 588348 516309)
= (clever-gcd 516309 72039)
= (clever-gcd 72039 12036)
= (clever-gcd 12036 11859)
= (clever-gcd 11859 177)
= (clever-gcd 177 0)
= 177

|#
