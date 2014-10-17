#|
(make-point 1 2 3)
is a value

(make-point (make-point 1 2 3) 4 5)
is a value

(make-point (+ 1 2) 3 4) 
is not a value since (+ 1 2) is not an atomic value. Nice explanation in the solution that points out the above 'has' a value but not 'is' a value. This is as different as saying James has a banana and James is a banana.
|#
