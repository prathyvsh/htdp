Data definition for list-of-two-symbols can be described as:

(cons 'y (cons 'x empty))

To be a legal list of symbols it is required that it follows the pattern:
(cons symbol list-of-symbols)

We know that empty though empty is a legal list of symbols.
So it follows that (cons 'x empty) is a list of symbols ('x being a legal symbol) which fits the format (cons symbol list-of-symbol). (cons 'y (cons 'x empty)) with 'y a legal symbol, also follows the above format where (cons 'x empty) has been shown to be a legal list of symbols. Hence list-of-two-symbols also belong to the class of list-of-symbols.
|#

