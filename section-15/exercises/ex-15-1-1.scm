;; Youngest Generation:
(define Gustav (make-parent empty 'Gustav 1988 'brown))

(define Fred&Eva (list Gustav))

;; Middle Generation:
(define Adam (make-parent empty 'Adam 1950 'yellow))
(define Dave (make-parent empty 'Dave 1955 'black))
(define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
(define Fred (make-parent Fred&Eva 'Fred 1966 'pink))

(define Carl&Bettina (list Adam Dave Eva))

;; Oldest Generation:
(define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
(define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))

#|
(blue-eyed-descendant? Eva)
(or (symbol=? (parent-eyes Eva) 'blue)
    (blue-eyed-children? (parent-children Eva)))
(or true (blue-eyed-children? (list Gustav)))
true

(blue-eyed-descendant? Bettina)
(or (symbol=? (parent-eyes Bettina) 'blue)
    (blue-eyed-children? (parent-children Bettina)))
(or false
    (blue-eyed-children? (list Adam Dave Eva)))

(or false
    (cond
      [(empty? (list Adam Dave Eva)) false]
    [else (or (blue-eyed-descendant? Adam)
              (blue-eyed-children? (list Dave Eva)))]))

(or false
    (or false (blue-eyed-children? (list Dave Eva))))

(or false (or false
    (cond
      [(empty? (list Dave Eva)) false]
    [else (or (blue-eyed-descendant? Dave)
              (blue-eyed-children? (list Eva)))])))

(or false (or false (or false (blue-eyed-children? (list Eva)))))

(or false (or false (or false
[(empty? aloc) (list Eva)]
    [else (or (blue-eyed-descendant? Eva)
              (blue-eyed-children? empty))])))

(or false (or false (or false (or true (blue-eyed-children? empty)))))

true
|#
