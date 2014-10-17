(blue-eyed-ancestor? empty) "done in ex-14-1-1"
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))


(define (blue-eyed-ancestor? a-ftree)
  (cond
    [(empty? a-ftree) false]
    [else (or (symbol=? (child-eyes a-ftree) 'blue) 
              (or (blue-eyed-ancestor? (child-father a-ftree))
                  (blue-eyed-ancestor? (child-mother a-ftree))))]))


(blue-eyed-ancestor? Gustav)

(cond
  [(empty? (make-child Fred Eva 'Gustav 1988 'brown)) false]
  [else (or (symbol=? (child-eyes (make-child Fred Eva 'Gustav 1988 'brown)) 'blue) 
            (or (blue-eyed-ancestor? (child-father (make-child Fred Eva 'Gustav 1988 'brown)))
                (blue-eyed-ancestor? (child-mother (make-child Fred Eva 'Gustav 1988 'brown)))))])


(cond
  [false false]
  [else (or (symbol=? (child-eyes (make-child Fred Eva 'Gustav 1988 'brown)) 'blue) 
            (or (blue-eyed-ancestor? (child-father (make-child Fred Eva 'Gustav 1988 'brown)))
                (blue-eyed-ancestor? (child-mother (make-child Fred Eva 'Gustav 1988 'brown)))))])
(cond
  [false false]
  [else (or (symbol=? 'brown 'blue) 
            (or (blue-eyed-ancestor? (child-father (make-child Fred Eva 'Gustav 1988 'brown)))
                (blue-eyed-ancestor? (child-mother (make-child Fred Eva 'Gustav 1988 'brown)))))])
(cond
  [false false]
  [else (or false
            (or (blue-eyed-ancestor? (child-father (make-child Fred Eva 'Gustav 1988 'brown)))
                (blue-eyed-ancestor? (child-mother (make-child Fred Eva 'Gustav 1988 'brown)))))])

(or false (or (blue-eyed-ancestor? Fred)
              (blue-eyed-ancestor? Eva)))

(or false (or (blue-eyed-ancestor? (make-child empty empty 'Fred 1966 'pink))
              (blue-eyed-ancestor? (make-child Carl Bettina 'Eva 1965 'blue))))

(or false (or (cond
                [(empty? (make-child empty empty 'Fred 1966 'pink)) false]
                [else (or (symbol=? (child-eyes (make-child empty empty 'Fred 1966 'pink)) 'blue)
                          (or (blue-eyed-ancestor? (child-father (make-child empty empty 'Fred 1966 'pink)))
                              (blue-eyed-ancestor? (child-mother (make-child empty empty 'Fred 1966 'pink)))))])
              (blue-eyed-ancestor? ((make-child Carl Bettina 'Eva 1965 'blue)))))

(or false (or (cond
                [false false]
                [else (or (symbol=? (child-eyes (make-child empty empty 'Fred 1966 'pink)) 'blue)
                          (or (blue-eyed-ancestor? (child-father (make-child empty empty 'Fred 1966 'pink)))
                              (blue-eyed-ancestor? (child-mother (make-child empty empty 'Fred 1966 'pink)))))])
              (blue-eyed-ancestor? ((make-child Carl Bettina 'Eva 1965 'blue)))))

(or false (or
            (or (symbol=? 'pink 'blue)
                (or (blue-eyed-ancestor? (child-father (make-child empty empty 'Fred 1966 'pink)))
                    (blue-eyed-ancestor? (child-mother (make-child empty empty 'Fred 1966 'pink)))))
            (blue-eyed-ancestor? ((make-child Carl Bettina 'Eva 1965 'blue)))))

(or false (or
            (or false (or (blue-eyed-ancestor? (child-father (make-child empty empty 'Fred 1966 'pink)))
                          (blue-eyed-ancestor? (child-mother (make-child empty empty 'Fred 1966 'pink)))))
            (blue-eyed-ancestor? ((make-child Carl Bettina 'Eva 1965 'blue)))))

(or false (or
            (or false (or (blue-eyed-ancestor? empty)
                          (blue-eyed-ancestor? empty)))
            (blue-eyed-ancestor? ((make-child Carl Bettina 'Eva 1965 'blue)))))

(or false (or (or false (or false false)) (blue-eyed-ancestor? ((make-child Carl Bettina 'Eva 1965 'blue)))))

(or false (or (or false (or false false)) (cond
                                            [(empty? (make-child Carl Bettina 'Eva 1965 'blue)) false]
                                            [else (or (symbol=? (child-eyes (make-child Carl Bettina 'Eva 1965 'blue)) 'blue) 
                                                      (or (blue-eyed-ancestor? (child-father (make-child Carl Bettina 'Eva 1965 'blue)))
                                                          (blue-eyed-ancestor? (child-mother (make-child Carl Bettina 'Eva 1965 'blue)))))])))

(or false (or (or false (or false false)) (cond
                                            [false false]
                                            [else (or (symbol=? (child-eyes (make-child Carl Bettina 'Eva 1965 'blue)) 'blue) 
                                                      (or (blue-eyed-ancestor? (child-father (make-child Carl Bettina 'Eva 1965 'blue)))
                                                          (blue-eyed-ancestor? (child-mother (make-child Carl Bettina 'Eva 1965 'blue)))))])))

(or false (or (or false (or false false))
              (or (symbol=? 'blue 'blue) 
                  (or (blue-eyed-ancestor? (child-father (make-child Carl Bettina 'Eva 1965 'blue)))
                      (blue-eyed-ancestor? (child-mother (make-child Carl Bettina 'Eva 1965 'blue)))))))
(or false (or (or false (or false false))
              (or true (or (blue-eyed-ancestor? (child-father (make-child Carl Bettina 'Eva 1965 'blue)))
                           (blue-eyed-ancestor? (child-mother (make-child Carl Bettina 'Eva 1965 'blue)))))))

(or false (or (or false (or false false)) true))

(or false true)

true
