;; poly : number  ->  number
(define (poly x)
 (* (- x 2) (- x 4)))
#step: 1
left: 3
right: 6
mid: 4.5
f(left): -1
f(right): 8
f(mid): 1.25

#step: 2
left: 3
right: 4.5
mid: 3.75
f(left): -1
f(right): 1.25
f(mid) = -0.4375

#step: 3
left: 3.75
right: 4.5
mid: 4.125
f(left): -0.4375
f(right): 1.25
f(mid): 0.265625

#step: 4
left: 3.75
right: 4.125
mid: 3.9375
f(left): -0.4375
f(right): 0.265625
f(mid): -0.12109375

#step: 5
left: 3.9375
right: 4.125
mid: 4.03125
f(left): -0.12109375
f(right): 0.265625
f(mid): 0.0634765625

The equation (* (- x 2) (- x 4)) contains a root in the interval [3.9375, 4.125]
