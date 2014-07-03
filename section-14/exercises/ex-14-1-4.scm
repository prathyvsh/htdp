;; A family-tree is either
;; empty or
;; (make-child family-tree family-tree 'symbol number 'symbol)
(define-struct child (father mother name date eyes))

;; count-persons : family-tree number -> number
;; Calculates the average age of all people in the family tree
(define (average-age a-ftree current-year)
  (/ (total-age a-ftree current-year) (count-persons a-ftree)))

;; total-age : family-tree number -> number
;; Calculates the total age of all people in the family tree
(define (total-age a-ftree current-year)
  (cond
    [(empty? a-ftree) 0]
    [else (+ (- current-year (child-date a-ftree))
             (total-age (child-father a-ftree) current-year)
             (total-age (child-mother a-ftree) current-year))]))

;; count-persons : family-tree -> number
;; Calculates the number of persons present in the family tree f-tree
(define (count-persons a-ftree)
  (cond
    [(empty? a-ftree) 0]
    [else (+ 1 (count-persons (child-father a-ftree))
             (count-persons (child-mother a-ftree)))]))

;; TESTS
;; Oldest Generation:
(define Carl (make-child empty empty 'Carl 1926 'green))
(define Bettina (make-child empty empty 'Bettina 1926 'green))

;; Middle Generation: 
(define Adam (make-child Carl Bettina 'Adam 1950 'yellow))
(define Dave (make-child Carl Bettina 'Dave 1955 'black))
(define Eva (make-child Carl Bettina 'Eva 1965 'blue))
(define Fred (make-child empty empty 'Fred 1966 'pink))

;; Youngest Generation: 
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))

(define (age child current-year)
  (- current-year (child-date child)))

(= (average-age Gustav 2014) (/ (+ (age Carl 2014)
                                (age Bettina 2014)
                                (age Fred 2014)
                                (age Eva 2014)
                                (age Gustav 2014)) 5))
(= (average-age Eva 2014) 75)
