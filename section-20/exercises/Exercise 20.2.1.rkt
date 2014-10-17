(number  ->  boolean)
;; Consumes a number and produces a boolean

(boolean symbol  ->  boolean)
;; Consumers a boolean and a symbol and produces a boolean

(number number number  ->  number)
;; Consumes three numbers and produces a number

(number  ->  (listof number))
;; Consumer a number and produces a list of numbers

((listof number)  ->  boolean)
;;Consumer a list of numbers and produces a boolean
