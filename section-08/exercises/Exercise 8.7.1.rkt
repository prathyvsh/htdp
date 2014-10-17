#|
GRAMMAR:
<def> = (define-struct <var0> (<var-1> ... <var-n>))

1. (define-struct personnel-record (name salary dob ssn))

Valid since it follows the grammar.

2. (define-struct oops ())

Invalid since it doesn't follow the grammar.

3. (define-struct child (dob date (- date dob)))

Illegal since it doesn't the grammar. (- date dob) is not a legal field name.

4. (define-struct (child person) (dob date))

Invalid since (child person) is not a legal name for the structure.

5. (define-struct child (parents dob date))

Valid since it follows the grammar.
|#
