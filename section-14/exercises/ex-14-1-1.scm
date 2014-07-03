#|
(blue-eyed-ancestor? empty)
(cond
  [(empty? empty) false]
  [else (or (symbol=? (child-eyes empty) 'blue)
            (or (blue-eyed-ancestor? (child-father empty))
                (blue-eyed-ancestor? (child-mother empty))))]))
(cond
  [true false]
  [else (or (symbol=? (child-eyes empty) 'blue)
            (or (blue-eyed-ancestor? (child-father empty))
                (blue-eyed-ancestor? (child-mother empty))))]))
true

(blue-eyed-ancestor? Carl)

(cond
  [(empty? (make-child empty empty 'Carl 1926 'green)) false]
  [else (or (symbol=? (child-eyes (make-child empty empty 'Carl 1926 'green)) 'blue)
            (or (blue-eyed-ancestor? (child-father (make-child empty empty 'Carl 1926 'green)))
                (blue-eyed-ancestor? (child-mother (make-child empty empty 'Carl 1926 'green)))))])

(cond
  [false false]
[else (or (symbol=? (child-eyes (make-child empty empty 'Carl 1926 'green)) 'blue)
            (or (blue-eyed-ancestor? (child-father (make-child empty empty 'Carl 1926 'green)))
                (blue-eyed-ancestor? (child-mother (make-child empty empty 'Carl 1926 'green)))))])

(or false (or (blue-eyed-ancestor? (child-father (make-child empty empty 'Carl 1926 'green)))
              (blue-eyed-ancestor? (child-mother (make-child empty empty 'Carl 1926 'green)))))

(or false (or false false))

false

|#
