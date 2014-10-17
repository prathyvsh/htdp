(lambda (x y) (x y y))
;; legal, since it is the application of y twice to function x

(lambda () 10)
;; illegal since there are no parameters for the function definition

(lambda (x) x)
;; legal, since it returns the x it accepts

(lambda (x y) x)
;; legal since it has valid parameters and return value

(lambda x 10)
;; illegal since it is not a function definition
